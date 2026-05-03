#!/usr/bin/env bash
set -euo pipefail

# CogniDoc Beacon Validator (Tier 1 — basic syntax validation)
# Usage: ./validate-beacons.sh <directory-or-file> [--strict]
# Example: ./validate-beacons.sh ~/my-project
# Example: ./validate-beacons.sh ~/my-project/COGNIDOC.md --strict
#
# Behavior:
# - Validates SBS beacon syntax in markdown files
# - Ignores beacons inside fenced code blocks (``` ... ```)
# - Ignores beacons inside inline code spans (`...`)
# - Reports malformed beacons with file:line context

if [ $# -lt 1 ]; then
    echo "Usage: $0 <directory-or-file> [--strict]"
    echo ""
    echo "Validates SBS beacon syntax in markdown files."
    echo ""
    echo "Options:"
    echo "  --strict    Exit with error code 1 if any issues found"
    echo ""
    echo "Checks:"
    echo "  - Beacon format: [*(DOM.W.ROL>DEST)*]"
    echo "  - Domain: 2-4 uppercase letters"
    echo "  - Weight: W1-W5"
    echo "  - Role: known role codes (DEF, DEC, DEP, REF, HIT, PAT, RIS, EVL, SIG)"
    echo "  - Destination: non-empty after >"
    echo "  - Pack beacons: valid | separator"
    echo ""
    echo "Code blocks (fenced or inline) are excluded from validation."
    exit 1
fi

TARGET="$1"
STRICT="${2:-}"

VALID_ROLES="DEF|DEC|DEP|REF|HIT|PAT|RIS|EVL|SIG"

echo "=== CogniDoc Beacon Validator ==="
echo "Target: $TARGET"
echo ""

if [ -f "$TARGET" ]; then
    FILES=("$TARGET")
elif [ -d "$TARGET" ]; then
    mapfile -t FILES < <(find "$TARGET" -name "*.md" -type f 2>/dev/null)
else
    echo "ERROR: $TARGET is not a file or directory"
    exit 1
fi

ISSUES=0
TOTAL_BEACONS=0
FILES_SCANNED=${#FILES[@]}

# Strip inline code spans `...` from a line
strip_inline_code() {
    local line="$1"
    # Remove anything between backticks (single backtick spans only — most common case)
    echo "$line" | sed 's/`[^`]*`//g'
}

for file in "${FILES[@]}"; do
    line_num=0
    in_fenced_code=0

    while IFS= read -r line || [ -n "$line" ]; do
        line_num=$((line_num + 1))

        # Toggle fenced code block state on lines starting with ```
        if [[ "$line" =~ ^[[:space:]]*\`\`\` ]]; then
            in_fenced_code=$((1 - in_fenced_code))
            continue
        fi

        # Skip lines inside fenced code blocks
        if [ "$in_fenced_code" -eq 1 ]; then
            continue
        fi

        # Strip inline code spans before scanning
        clean_line=$(strip_inline_code "$line")

        # Extract beacons from the cleaned line
        beacons_in_line=()
        while IFS= read -r b; do
            [ -n "$b" ] && beacons_in_line+=("$b")
        done < <(echo "$clean_line" | grep -oP '\[\*\([^)]+\)\*\]' 2>/dev/null || true)

        for beacon in "${beacons_in_line[@]}"; do
            TOTAL_BEACONS=$((TOTAL_BEACONS + 1))

            inner="${beacon#\[\*\(}"
            inner="${inner%\)\*\]}"

            IFS='|' read -ra parts <<< "$inner"

            for part in "${parts[@]}"; do
                part="${part#"${part%%[![:space:]]*}"}"
                part="${part%"${part##*[![:space:]]}"}"

                if ! [[ "$part" =~ ^[A-Z]{2,4}\.W[1-5]\.($VALID_ROLES)\>[^[:space:]]+$ ]]; then
                    echo "  ISSUE [$file:$line_num]: malformed beacon component: '$part'"
                    echo "    Full beacon: $beacon"
                    echo "    Expected: DOM.W[1-5].ROLE>DESTINATION"
                    ISSUES=$((ISSUES + 1))
                fi
            done
        done
    done < "$file"
done

echo ""
echo "=== Results ==="
echo "Files scanned: $FILES_SCANNED"
echo "Beacons found: $TOTAL_BEACONS"
echo "Issues:        $ISSUES"

if [ "$ISSUES" -gt 0 ]; then
    echo ""
    echo "STATUS: $ISSUES issue(s) found."
    if [ "$STRICT" = "--strict" ]; then
        exit 1
    fi
else
    if [ "$TOTAL_BEACONS" -eq 0 ]; then
        echo ""
        echo "STATUS: No beacons found. This is fine for a new project."
    else
        echo ""
        echo "STATUS: All beacons valid."
    fi
fi
