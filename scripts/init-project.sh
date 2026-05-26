#!/usr/bin/env bash
# init-project.sh
#
# Scaffold a new concept film project by copying the selected renderer template.
#
# Usage:
#   scripts/init-project.sh <project-directory> [--renderer hyperframes|remotion]
#
# Example:
#   scripts/init-project.sh ~/concepts/signatures-law

set -euo pipefail

usage() {
  echo "Usage: $0 <project-directory> [--renderer remotion|hyperframes]" >&2
  echo "Example: $0 ~/concepts/signatures-law --renderer remotion" >&2
}

if [ $# -lt 1 ]; then
  usage
  exit 1
fi

SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=scripts/lib/renderers.sh
source "$SKILL_DIR/scripts/lib/renderers.sh"

PROJECT_DIR=""
REQUESTED_RENDERER=""

while [ $# -gt 0 ]; do
  case "$1" in
    --renderer)
      if [ $# -lt 2 ]; then
        usage
        exit 1
      fi
      REQUESTED_RENDERER="$2"
      shift 2
      ;;
    --renderer=*)
      REQUESTED_RENDERER="${1#*=}"
      shift
      ;;
    -h | --help)
      usage
      exit 0
      ;;
    -*)
      echo "Error: unknown option $1" >&2
      usage
      exit 1
      ;;
    *)
      if [ -n "$PROJECT_DIR" ]; then
        echo "Error: unexpected extra argument $1" >&2
        usage
        exit 1
      fi
      PROJECT_DIR="$1"
      shift
      ;;
  esac
done

if [ -z "$PROJECT_DIR" ]; then
  usage
  exit 1
fi

RENDERER="$(renderer_from_project "$PROJECT_DIR" "$REQUESTED_RENDERER")"
TEMPLATE_DIR="$(renderer_template_dir "$SKILL_DIR" "$RENDERER")"
RENDERER_DIR="$(renderer_project_dir "$PROJECT_DIR" "$RENDERER")"

if [ ! -d "$TEMPLATE_DIR" ]; then
  echo "Error: $RENDERER template not found at $TEMPLATE_DIR" >&2
  exit 1
fi

mkdir -p "$PROJECT_DIR/out"
write_renderer_config "$PROJECT_DIR" "$RENDERER"

if [ ! -d "$RENDERER_DIR" ]; then
  echo "→ Copying $RENDERER template to $RENDERER_DIR"
  cp -R "$TEMPLATE_DIR" "$RENDERER_DIR"
  rm -rf "$RENDERER_DIR/node_modules"
else
  echo "→ $RENDERER project already exists at $RENDERER_DIR (skipping copy)"
fi

mkdir -p "$RENDERER_DIR/public/audio"
mkdir -p "$RENDERER_DIR/public/screens"
mkdir -p "$RENDERER_DIR/public/imagery"
mkdir -p "$RENDERER_DIR/public/fonts"

for f in brief.md script.md motion-board.md design.md; do
  if [ ! -f "$PROJECT_DIR/$f" ]; then
    title="$(printf '%s' "$f" | sed 's/\.md$//' | tr '[:lower:]' '[:upper:]')"
    printf '# %s\n\n_Pending — to be filled by the skill._\n' "$title" > "$PROJECT_DIR/$f"
  fi
done

if [ ! -f "$PROJECT_DIR/voice.json" ]; then
  cat > "$PROJECT_DIR/voice.json" << 'JSON'
{
  "voice_id": null,
  "voice_name": null,
  "model": "eleven_v3",
  "audition_notes": null,
  "settings": {
    "stability": 0.5,
    "similarity_boost": 0.75,
    "style": 0.0,
    "use_speaker_boost": true
  }
}
JSON
fi

if [ "$RENDERER" = "hyperframes" ]; then
  (
    cd "$RENDERER_DIR"
    node scripts/generate-data.mjs
  )
fi

echo ""
echo "✓ Project initialized at $PROJECT_DIR"
echo "✓ Renderer: $RENDERER"
echo ""
echo "Next steps:"
if [ "$RENDERER" = "hyperframes" ]; then
  echo "  1. Skill writes design tokens to $RENDERER_DIR/data/tokens.json"
  echo "  2. Skill renders $PROJECT_DIR/out/design-thumbnail.png for Phase 4 review"
  echo "  3. Skill writes film data to $RENDERER_DIR/data/film.json"
else
  echo "  1. Skill writes design tokens to $RENDERER_DIR/src/compositions/shared/BrandTokens.ts"
  echo "  2. Skill renders $PROJECT_DIR/out/design-thumbnail.png for Phase 4 review"
  echo "  3. Skill writes film data to $RENDERER_DIR/src/data/film.ts"
fi
echo "  4. Skill places hook audio at $RENDERER_DIR/public/audio/hook.mp3"
echo "  5. Skill places product screens at $RENDERER_DIR/public/screens/"
echo "  6. Run scripts/render-hook.sh $PROJECT_DIR to render the hook and cover frame"
