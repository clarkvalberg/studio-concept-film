#!/usr/bin/env bash
# render-hook.sh
#
# Render only the hook (first ~15 seconds) of a concept film, then export
# frame 0 as the poster/cover frame. The hook is the iteration unit.
#
# Usage:
#   scripts/render-hook.sh <project-directory>

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

if [ ! -f "$HYPERFRAMES_DIR/public/audio/hook.mp3" ]; then
  echo "Error: Hook audio not found at $HYPERFRAMES_DIR/public/audio/hook.mp3" >&2
  echo "Generate voiceover for the hook section first (Cold Open + Problem)." >&2
  exit 1
fi

mkdir -p "$OUT_DIR"
tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

echo "→ Rendering hook"
(
  cd "$HYPERFRAMES_DIR"
  STUDIO_RENDER_MODE=hook node scripts/generate-data.mjs
  npx --yes hyperframes@0.6.46 render \
    --composition compositions/hook.html \
    --output "../out/hook.mp4" \
    --quality standard

  echo "→ Exporting cover frame"
  npx --yes hyperframes@0.6.46 render \
    --composition compositions/hook.html \
    --format png-sequence \
    --fps 1 \
    --quality draft \
    --workers 1 \
    --output "$tmp_dir"
)

cp "$tmp_dir/frame_000001.png" "$OUT_DIR/cover-frame.png"

echo ""
echo "✓ Hook rendered to $OUT_DIR/hook.mp4"
echo "✓ Cover frame rendered to $OUT_DIR/cover-frame.png"
