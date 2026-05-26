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
  echo "Usage: $0 <project-directory>" >&2
  exit 1
fi

PROJECT_DIR="$1"
HYPERFRAMES_DIR="$PROJECT_DIR/hyperframes"
OUT_DIR="$PROJECT_DIR/out"

if [ ! -d "$HYPERFRAMES_DIR" ]; then
  echo "Error: HyperFrames project not found at $HYPERFRAMES_DIR" >&2
  echo "Run scripts/init-project.sh first." >&2
  exit 1
fi

if [ ! -f "$HYPERFRAMES_DIR/public/audio/voiceover.mp3" ]; then
  echo "Error: Full voiceover audio not found at $HYPERFRAMES_DIR/public/audio/voiceover.mp3" >&2
  echo "Generate the full voiceover from the complete script first." >&2
  exit 1
fi

mkdir -p "$OUT_DIR"

echo "→ Rendering full film"
(
  cd "$HYPERFRAMES_DIR"
  STUDIO_RENDER_MODE=full node scripts/generate-data.mjs
  npx --yes hyperframes@0.6.46 render \
    --composition compositions/full.html \
    --output "../out/final.mp4" \
    --quality high
)

echo ""
echo "✓ Film rendered to $OUT_DIR/final.mp4"
