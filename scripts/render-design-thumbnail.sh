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
REMOTION_DIR="$PROJECT_DIR/remotion"
OUT_DIR="$PROJECT_DIR/out"

if [ ! -d "$REMOTION_DIR" ]; then
  echo "Error: Remotion project not found at $REMOTION_DIR" >&2
  echo "Run scripts/init-project.sh $PROJECT_DIR first." >&2
  exit 1
fi

if [ ! -f "$REMOTION_DIR/src/compositions/shared/BrandTokens.ts" ]; then
  echo "Error: Design tokens not found at $REMOTION_DIR/src/compositions/shared/BrandTokens.ts" >&2
  echo "Write Phase 4 design tokens before rendering the thumbnail." >&2
  exit 1
fi

if [ ! -f "$REMOTION_DIR/src/data/film.ts" ]; then
  echo "Error: Film data not found at $REMOTION_DIR/src/data/film.ts" >&2
  echo "Write at least placeholder film data before rendering the thumbnail." >&2
  exit 1
fi

mkdir -p "$OUT_DIR"

echo "→ Rendering design thumbnail"
cd "$REMOTION_DIR"
npx remotion still src/index.ts DesignThumbnail "../out/design-thumbnail.png" --frame=45
cd - > /dev/null

echo "✓ Design thumbnail rendered to $OUT_DIR/design-thumbnail.png"
