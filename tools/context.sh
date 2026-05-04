#!/usr/bin/env bash
set -euo pipefail

# CogniDoc Context Bundler
# Concatenates all CogniDoc files into a single markdown block suitable for
# pasting into any LLM (ChatGPT, Gemini, Claude web, Ollama, LM Studio, etc.)
#
# Usage:
#   ./tools/context.sh <project-dir>                  # output to stdout
#   ./tools/context.sh <project-dir> -o context.txt   # output to file
#   ./tools/context.sh <project-dir> --no-missions     # skip mission files
#
# Examples:
#   # Copy to clipboard for pasting into ChatGPT/Gemini:
#   ./tools/context.sh ~/my-project | pbcopy       # macOS
#   ./tools/context.sh ~/my-project | xclip -sel c # Linux
#
#   # Save to file for upload:
#   ./tools/context.sh ~/my-project > context.txt
#
#   # Pipe directly to a local LLM:
#   ./tools/context.sh ~/my-project | ollama run qwen2.5
#
# Dependencies: bash, cat, find (no exotic tools)

usage() {
    cat <<'USAGE'
CogniDoc Context Bundler — Bundle cognitive docs into a single LLM-ready block.

Usage: context.sh <project-dir> [options]

Arguments:
  project-dir         Path to the project initialized with CogniDoc

Options:
  -o, --output FILE   Write output to FILE instead of stdout
  --no-missions       Skip individual mission files (include only bootloader,
                      MEMORY.md, and SIGNAL_REGISTRY.md)
  --missions-only     Include only active mission files (skip completed ones)
  -h, --help          Show this help message

Examples:
  context.sh ~/my-project                        # stdout
  context.sh ~/my-project | pbcopy               # macOS clipboard
  context.sh ~/my-project | xclip -sel c         # Linux clipboard
  context.sh ~/my-project -o context.txt         # save to file
  context.sh ~/my-project | ollama run qwen2.5   # pipe to local LLM
  context.sh ~/my-project --no-missions          # bootloader + memory only

USAGE
    exit 0
}

# --- Parse arguments ---

PROJECT_DIR=""
OUTPUT_FILE=""
INCLUDE_MISSIONS=true
MISSIONS_ONLY_ACTIVE=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            usage
            ;;
        -o|--output)
            if [[ -z "${2:-}" ]]; then
                echo "ERROR: --output requires a file path" >&2
                exit 1
            fi
            OUTPUT_FILE="$2"
            shift 2
            ;;
        --no-missions)
            INCLUDE_MISSIONS=false
            shift
            ;;
        --missions-only)
            MISSIONS_ONLY_ACTIVE=true
            shift
            ;;
        -*)
            echo "ERROR: Unknown option: $1" >&2
            echo "Run with --help for usage." >&2
            exit 1
            ;;
        *)
            if [[ -z "$PROJECT_DIR" ]]; then
                PROJECT_DIR="$1"
            else
                echo "ERROR: Unexpected argument: $1" >&2
                exit 1
            fi
            shift
            ;;
    esac
done

if [[ -z "$PROJECT_DIR" ]]; then
    echo "ERROR: Project directory is required." >&2
    echo "Run with --help for usage." >&2
    exit 1
fi

# Resolve to absolute path
PROJECT_DIR="$(cd "$PROJECT_DIR" 2>/dev/null && pwd)" || {
    echo "ERROR: Directory not found: $PROJECT_DIR" >&2
    exit 1
}

# --- Locate CogniDoc files ---

BOOTLOADER=""
if [[ -f "$PROJECT_DIR/COGNIDOC.md" ]]; then
    BOOTLOADER="$PROJECT_DIR/COGNIDOC.md"
elif [[ -f "$PROJECT_DIR/CLAUDE.md" ]]; then
    # Support Claude Code integration (auto-reads CLAUDE.md)
    BOOTLOADER="$PROJECT_DIR/CLAUDE.md"
else
    echo "ERROR: No bootloader found. Expected COGNIDOC.md in $PROJECT_DIR" >&2
    exit 1
fi

MEMORY_FILE="$PROJECT_DIR/MEMORY.md"
SIGNAL_FILE="$PROJECT_DIR/SIGNAL_REGISTRY.md"
HANDSHAKES_FILE="$PROJECT_DIR/HANDSHAKES.md"
MISSIONS_DIR="$PROJECT_DIR/missions"
HANDSHAKES_DIR="$PROJECT_DIR/handshakes"

# --- Build output ---

generate() {
    # Header instruction
    cat <<'HEADER'
# CogniDoc — Cognitive Documentation Context

You are an LLM assistant working on this project. The following is your
cognitive documentation system. Read it, internalize the protocols, and
follow them for all operations.

The context below contains:
1. **Bootloader** — the protocol that governs how you operate on this project
2. **Project Memory** — the living state of the project
3. **Signal Registry** — the state tracker for missions and processes
4. **Handshakes Index** — chronological narrative checkpoints (one per commit)
5. **Mission Files** — individual mission details (if included)
6. **Recent Handshakes** — the 3 most recent narrative checkpoints (full content)

Each section is delimited with clear markers. Process them in order.

---

HEADER

    # Section 1: Bootloader
    echo "<!-- ====== SECTION 1: BOOTLOADER (COGNIDOC.md) ====== -->"
    echo ""
    if [[ -f "$BOOTLOADER" ]]; then
        cat "$BOOTLOADER"
    fi
    echo ""
    echo ""
    echo "<!-- ====== END BOOTLOADER ====== -->"
    echo ""
    echo "---"
    echo ""

    # Section 2: Project Memory
    echo "<!-- ====== SECTION 2: PROJECT MEMORY (MEMORY.md) ====== -->"
    echo ""
    if [[ -f "$MEMORY_FILE" ]]; then
        cat "$MEMORY_FILE"
    else
        echo "*MEMORY.md not found — project memory has not been initialized yet.*"
    fi
    echo ""
    echo ""
    echo "<!-- ====== END PROJECT MEMORY ====== -->"
    echo ""
    echo "---"
    echo ""

    # Section 3: Signal Registry
    echo "<!-- ====== SECTION 3: SIGNAL REGISTRY (SIGNAL_REGISTRY.md) ====== -->"
    echo ""
    if [[ -f "$SIGNAL_FILE" ]]; then
        cat "$SIGNAL_FILE"
    else
        echo "*SIGNAL_REGISTRY.md not found — signal registry has not been initialized yet.*"
    fi
    echo ""
    echo ""
    echo "<!-- ====== END SIGNAL REGISTRY ====== -->"
    echo ""
    echo "---"
    echo ""

    # Section 4: Handshakes index
    echo "<!-- ====== SECTION 4: HANDSHAKES INDEX (HANDSHAKES.md) ====== -->"
    echo ""
    if [[ -f "$HANDSHAKES_FILE" ]]; then
        cat "$HANDSHAKES_FILE"
    else
        echo "*HANDSHAKES.md not found — handshake index has not been initialized yet.*"
    fi
    echo ""
    echo ""
    echo "<!-- ====== END HANDSHAKES INDEX ====== -->"
    echo ""

    # Section 5: Mission files
    if [[ "$INCLUDE_MISSIONS" == true ]] && [[ -d "$MISSIONS_DIR" ]]; then
        # Find mission files (*.md), excluding the template
        mapfile -t mission_files < <(
            find "$MISSIONS_DIR" -name "*.md" -type f ! -name "_template.md" 2>/dev/null | sort
        )

        if [[ ${#mission_files[@]} -gt 0 ]]; then
            echo "---"
            echo ""
            echo "<!-- ====== SECTION 5: MISSION FILES ====== -->"
            echo ""

            for mfile in "${mission_files[@]}"; do
                # Get path relative to project dir
                rel_path="${mfile#"$PROJECT_DIR"/}"

                # If --missions-only, try to skip completed missions
                if [[ "$MISSIONS_ONLY_ACTIVE" == true ]]; then
                    if grep -qi 'Estado:.*COMPLETAD' "$mfile" 2>/dev/null || \
                       grep -qi 'Status:.*COMPLETED' "$mfile" 2>/dev/null; then
                        continue
                    fi
                fi

                echo "<!-- ------ Mission: $rel_path ------ -->"
                echo ""
                cat "$mfile"
                echo ""
                echo ""
                echo "<!-- ------ End: $rel_path ------ -->"
                echo ""
            done

            echo "<!-- ====== END MISSION FILES ====== -->"
            echo ""
        fi
    fi

    # Section 6: Handshake files (latest 3 by default for context budget)
    if [[ -d "$HANDSHAKES_DIR" ]]; then
        mapfile -t handshake_files < <(
            find "$HANDSHAKES_DIR" -name "hs-*.md" -type f ! -name "_template.md" 2>/dev/null | sort | tail -3
        )

        if [[ ${#handshake_files[@]} -gt 0 ]]; then
            echo "---"
            echo ""
            echo "<!-- ====== SECTION 6: RECENT HANDSHAKES (last 3) ====== -->"
            echo ""

            for hfile in "${handshake_files[@]}"; do
                rel_path="${hfile#"$PROJECT_DIR"/}"
                echo "<!-- ------ Handshake: $rel_path ------ -->"
                echo ""
                cat "$hfile"
                echo ""
                echo ""
                echo "<!-- ------ End: $rel_path ------ -->"
                echo ""
            done

            echo "<!-- ====== END HANDSHAKES ====== -->"
            echo ""
        fi
    fi

    # Footer
    cat <<'FOOTER'
---

<!-- End of CogniDoc context. You now have the full cognitive state of this
     project. Follow the bootloader protocol for all operations. -->
FOOTER
}

# --- Output ---

if [[ -n "$OUTPUT_FILE" ]]; then
    generate > "$OUTPUT_FILE"
    echo "Context written to: $OUTPUT_FILE" >&2
    echo "Size: $(wc -c < "$OUTPUT_FILE" | tr -d ' ') bytes, $(wc -l < "$OUTPUT_FILE" | tr -d ' ') lines" >&2
else
    generate
fi
