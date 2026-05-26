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

if [ ! -f "$AUDIO_DIR/voiceover.mp3" ]; then
  echo "Error: Full voiceover audio not found at $AUDIO_DIR/voiceover.mp3" >&2
  echo "Generate the full voiceover from the complete script first." >&2
  exit 1
fi

mkdir -p "$OUT_DIR"

if [ "$RENDERER" = "hyperframes" ]; then
  echo "→ Rendering full film with HyperFrames"
  (
    cd "$RENDERER_DIR"
    STUDIO_RENDER_MODE=full node scripts/generate-data.mjs
    npx --yes hyperframes@0.6.46 render \
      --composition compositions/full.html \
      --output "../out/final.mp4" \
      --quality high
  )
elif [ "$RENDERER" = "remotion" ]; then
  ensure_node_package_deps "$RENDERER_DIR" "Remotion"
  echo "→ Rendering full film with Remotion"
  (
    cd "$RENDERER_DIR"
    npx --no-install remotion render src/index.ts Full "../out/final.mp4"
  )
fi

echo ""
echo "✓ Film rendered to $OUT_DIR/final.mp4"
