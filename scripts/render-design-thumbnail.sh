#!/usr/bin/env bash
# render-design-thumbnail.sh
#
# Render the Phase 4 design thumbnail: a static title-frame artifact used to
# validate visual language before voice audition or hook rendering.
#
# Usage:
#   scripts/render-design-thumbnail.sh <project-directory>

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
  echo "Run scripts/init-project.sh $PROJECT_DIR first." >&2
  exit 1
fi

if [ ! -f "$HYPERFRAMES_DIR/data/tokens.json" ]; then
  echo "Error: Design tokens not found at $HYPERFRAMES_DIR/data/tokens.json" >&2
  echo "Write Phase 4 design tokens before rendering the thumbnail." >&2
  exit 1
fi

if [ ! -f "$HYPERFRAMES_DIR/data/film.json" ]; then
  echo "Error: Film data not found at $HYPERFRAMES_DIR/data/film.json" >&2
  echo "Write at least placeholder film data before rendering the thumbnail." >&2
  exit 1
fi

mkdir -p "$OUT_DIR"
tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

echo "→ Rendering design thumbnail"
(
  cd "$HYPERFRAMES_DIR"
  STUDIO_RENDER_MODE=design node scripts/generate-data.mjs
  npx --yes hyperframes@0.6.46 render \
    --composition compositions/design-thumbnail.html \
    --format png-sequence \
    --fps 1 \
    --quality draft \
    --workers 1 \
    --output "$tmp_dir"
)

cp "$tmp_dir/frame_000002.png" "$OUT_DIR/design-thumbnail.png"
echo "✓ Design thumbnail rendered to $OUT_DIR/design-thumbnail.png"
