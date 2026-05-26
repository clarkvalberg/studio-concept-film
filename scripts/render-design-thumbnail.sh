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
OUT_DIR="$PROJECT_DIR/out"
SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=scripts/lib/renderers.sh
source "$SKILL_DIR/scripts/lib/renderers.sh"

RENDERER="$(renderer_from_project "$PROJECT_DIR")"
RENDERER_DIR="$(renderer_project_dir "$PROJECT_DIR" "$RENDERER")"

if [ ! -d "$RENDERER_DIR" ]; then
  echo "Error: $RENDERER project not found at $RENDERER_DIR" >&2
  echo "Run scripts/init-project.sh $PROJECT_DIR --renderer $RENDERER first." >&2
  exit 1
fi

mkdir -p "$OUT_DIR"

if [ "$RENDERER" = "hyperframes" ]; then
  if [ ! -f "$RENDERER_DIR/data/tokens.json" ]; then
    echo "Error: Design tokens not found at $RENDERER_DIR/data/tokens.json" >&2
    echo "Write Phase 4 design tokens before rendering the thumbnail." >&2
    exit 1
  fi

  if [ ! -f "$RENDERER_DIR/data/film.json" ]; then
    echo "Error: Film data not found at $RENDERER_DIR/data/film.json" >&2
    echo "Write at least placeholder film data before rendering the thumbnail." >&2
    exit 1
  fi

  tmp_dir="$(mktemp -d)"
  trap 'rm -rf "$tmp_dir"' EXIT

  echo "→ Rendering design thumbnail with HyperFrames"
  (
    cd "$RENDERER_DIR"
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
elif [ "$RENDERER" = "remotion" ]; then
  if [ ! -f "$RENDERER_DIR/src/compositions/shared/BrandTokens.ts" ]; then
    echo "Error: Design tokens not found at $RENDERER_DIR/src/compositions/shared/BrandTokens.ts" >&2
    echo "Write Phase 4 design tokens before rendering the thumbnail." >&2
    exit 1
  fi

  if [ ! -f "$RENDERER_DIR/src/data/film.ts" ]; then
    echo "Error: Film data not found at $RENDERER_DIR/src/data/film.ts" >&2
    echo "Write at least placeholder film data before rendering the thumbnail." >&2
    exit 1
  fi

  ensure_node_package_deps "$RENDERER_DIR" "Remotion"
  echo "→ Rendering design thumbnail with Remotion"
  (
    cd "$RENDERER_DIR"
    npx --no-install remotion still src/index.ts DesignThumbnail "../out/design-thumbnail.png" --frame=45
  )
fi

echo "✓ Design thumbnail rendered to $OUT_DIR/design-thumbnail.png"
