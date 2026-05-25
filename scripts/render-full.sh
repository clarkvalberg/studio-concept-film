#!/usr/bin/env bash
# render-full.sh
#
# Render the complete concept film (60-90s typically).
# Only run after the hook has been approved.
#
# Usage:
#   scripts/render-full.sh <project-directory>

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

if [ ! -f "$REMOTION_DIR/public/audio/voiceover.mp3" ]; then
  echo "Error: Full voiceover audio not found at $REMOTION_DIR/public/audio/voiceover.mp3"
  echo "Generate the full voiceover from the complete script first."
  exit 1
fi

mkdir -p "$OUT_DIR"

echo "→ Rendering full film (this takes ~5-10 minutes for 1080p)"
cd "$REMOTION_DIR"
npx remotion render src/index.ts Full "../out/final.mp4"
cd - > /dev/null

echo ""
echo "✓ Film rendered to $OUT_DIR/final.mp4"
