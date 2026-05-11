#!/usr/bin/env bash
set -euo pipefail

# MandelDoc Project Initializer
# Usage: ./init.sh <target-dir> <project-name>
# Example: ./init.sh ~/my-project "My Awesome Project"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MANDELDOC_ROOT="$(dirname "$SCRIPT_DIR")"

if [ $# -lt 2 ]; then
    echo "Usage: $0 <target-directory> <project-name>"
    echo ""
    echo "Arguments:"
    echo "  target-directory  Path where the MandelDoc structure will be created"
    echo "  project-name      Name of your project (used in templates)"
    echo ""
    echo "Examples:"
    echo "  $0 ~/my-app \"My App\""
    echo "  $0 ./research \"PhD Thesis\""
    echo "  $0 /opt/project \"Enterprise Platform\""
    exit 1
fi

TARGET_DIR="$1"
PROJECT_NAME="$2"

echo "=== MandelDoc Project Initializer ==="
echo "Target:  $TARGET_DIR"
echo "Project: $PROJECT_NAME"
echo ""

if [ -f "$TARGET_DIR/MANDELDOC.md" ]; then
    echo "ERROR: $TARGET_DIR/MANDELDOC.md already exists."
    echo "This directory appears to already have a MandelDoc setup."
    echo "Remove MANDELDOC.md manually if you want to reinitialize."
    exit 1
fi

mkdir -p "$TARGET_DIR/missions"

echo "[1/5] Creating bootloader (MANDELDOC.md)..."
DATE_TODAY=$(date +%Y-%m-%d)
sed \
    -e "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" \
    -e "s/{{ORG}}/your-org/g" \
    -e "s|{{PROJECT_ROOT}}|.|g" \
    "$MANDELDOC_ROOT/bootloader/MANDELDOC.md.template" \
    > "$TARGET_DIR/MANDELDOC.md"

echo "[2/5] Creating project memory (MEMORY.md)..."
sed \
    -e "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" \
    -e "s/{{VERSION}}/0.4.0/g" \
    -e "s/{{DATE}}/$DATE_TODAY/g" \
    -e "s/{{OWNER}}/$PROJECT_NAME team/g" \
    -e "s|{{PROJECT_ROOT}}|.|g" \
    "$MANDELDOC_ROOT/templates/MEMORY.md.template" \
    > "$TARGET_DIR/MEMORY.md"

echo "[3/6] Creating signal registry (SIGNAL_REGISTRY.md)..."
sed \
    -e "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" \
    -e "s/{{DATE}}/$DATE_TODAY/g" \
    "$MANDELDOC_ROOT/templates/SIGNAL_REGISTRY.md.template" \
    > "$TARGET_DIR/SIGNAL_REGISTRY.md"

echo "[4/6] Creating handshakes index (HANDSHAKES.md)..."
sed \
    -e "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" \
    -e "s/{{DATE}}/$DATE_TODAY/g" \
    "$MANDELDOC_ROOT/templates/HANDSHAKES.md.template" \
    > "$TARGET_DIR/HANDSHAKES.md"

echo "[5/6] Copying mission template..."
cp "$MANDELDOC_ROOT/templates/missions/_template.md" \
   "$TARGET_DIR/missions/_template.md"

echo "[6/6] Copying handshake template..."
mkdir -p "$TARGET_DIR/handshakes"
cp "$MANDELDOC_ROOT/templates/handshakes/_template.md" \
   "$TARGET_DIR/handshakes/_template.md"

echo ""
echo "=== MandelDoc initialized successfully ==="
echo ""
echo "Structure created:"
echo "  $TARGET_DIR/"
echo "  ├── MANDELDOC.md             <- Bootloader (LLM reads this first)"
echo "  ├── MEMORY.md               <- Project memory"
echo "  ├── SIGNAL_REGISTRY.md      <- Process state tracker"
echo "  ├── HANDSHAKES.md           <- Handshake index (chronological checkpoints)"
echo "  ├── missions/"
echo "  │   └── _template.md        <- Template for new missions"
echo "  └── handshakes/"
echo "      └── _template.md        <- Template for narrative checkpoints"
echo ""
echo "Next steps:"
echo "  1. Open MANDELDOC.md and review/customize the protocol"
echo "  2. Fill in MEMORY.md sections 1, 2, and 4 with your project info"
echo "  3. Feed MANDELDOC.md to your LLM (see docs/getting-started.md for your LLM type)"
echo "  4. Try: 'access memory' to verify the LLM loaded your context"
echo "  5. Before your first commit: 'new handshake' to generate HS-001"
echo ""
echo "Docs: https://github.com/xuspitillo/MandelDoc/blob/main/docs/getting-started.md"
