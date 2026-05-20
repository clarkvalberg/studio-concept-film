#!/usr/bin/env bash
# render-hook.sh
#
# Render only the hook (first ~15 seconds) of a concept film.
# This is the iteration unit — render this for rapid feedback before
# committing to a full render.
#
# Usage:
#   scripts/render-hook.sh <project-directory>

set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <project-directory>"
  exit 1
fi

PROJECT_DIR="$1"
REMOTION_DIR="$PROJECT_DIR/remotion"
OUT_DIR="$PROJECT_DIR/out"

if [ ! -d "$REMOTION_DIR" ]; then
  echo "Error: Remotion project not found at $REMOTION_DIR"
  echo "Run scripts/init-project.sh first."
  exit 1
fi

if [ ! -f "$REMOTION_DIR/public/audio/hook.mp3" ]; then
  echo "Error: Hook audio not found at $REMOTION_DIR/public/audio/hook.mp3"
  echo "Generate voiceover for the hook section first (Cold Open + Problem)."
  exit 1
fi

mkdir -p "$OUT_DIR"

echo "→ Rendering hook (this takes ~2-4 minutes)"
cd "$REMOTION_DIR"
npx remotion render src/index.ts Hook "../out/hook.mp4"
cd - > /dev/null

echo ""
echo "✓ Hook rendered to $OUT_DIR/hook.mp4"
