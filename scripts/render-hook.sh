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
OUT_DIR="$PROJECT_DIR/out"
SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=scripts/lib/renderers.sh
source "$SKILL_DIR/scripts/lib/renderers.sh"

RENDERER="$(renderer_from_project "$PROJECT_DIR")"
RENDERER_DIR="$(renderer_project_dir "$PROJECT_DIR" "$RENDERER")"
AUDIO_DIR="$(renderer_audio_dir "$PROJECT_DIR" "$RENDERER")"

if [ ! -d "$RENDERER_DIR" ]; then
  echo "Error: $RENDERER project not found at $RENDERER_DIR" >&2
  echo "Run scripts/init-project.sh first." >&2
  exit 1
fi

if [ ! -f "$AUDIO_DIR/hook.mp3" ]; then
  echo "Error: Hook audio not found at $AUDIO_DIR/hook.mp3" >&2
  echo "Generate voiceover for the hook section first (Cold Open + Problem)." >&2
  exit 1
fi

mkdir -p "$OUT_DIR"

if [ "$RENDERER" = "hyperframes" ]; then
  tmp_dir="$(mktemp -d)"
  trap 'rm -rf "$tmp_dir"' EXIT

  echo "→ Rendering hook with HyperFrames"
  (
    cd "$RENDERER_DIR"
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
elif [ "$RENDERER" = "remotion" ]; then
  ensure_node_package_deps "$RENDERER_DIR" "Remotion"
  echo "→ Rendering hook with Remotion"
  (
    cd "$RENDERER_DIR"
    npx --no-install remotion render src/index.ts Hook "../out/hook.mp4"
    echo "→ Exporting cover frame"
    npx --no-install remotion still src/index.ts Hook "../out/cover-frame.png" --frame=0
  )
fi

echo ""
echo "✓ Hook rendered to $OUT_DIR/hook.mp4"
echo "✓ Cover frame rendered to $OUT_DIR/cover-frame.png"
