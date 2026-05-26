#!/usr/bin/env bash
# init-project.sh
#
# Scaffold a new concept film project by copying the HyperFrames template.
#
# Usage:
#   scripts/init-project.sh <project-directory>
#
# Example:
#   scripts/init-project.sh ~/concepts/signatures-law

set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <project-directory>" >&2
  echo "Example: $0 ~/concepts/signatures-law" >&2
  exit 1
fi

PROJECT_DIR="$1"
SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMPLATE_DIR="$SKILL_DIR/assets/hyperframes-template"
HYPERFRAMES_DIR="$PROJECT_DIR/hyperframes"

if [ ! -d "$TEMPLATE_DIR" ]; then
  echo "Error: HyperFrames template not found at $TEMPLATE_DIR" >&2
  exit 1
fi

mkdir -p "$PROJECT_DIR/out"

if [ ! -d "$HYPERFRAMES_DIR" ]; then
  echo "→ Copying HyperFrames template to $HYPERFRAMES_DIR"
  cp -R "$TEMPLATE_DIR" "$HYPERFRAMES_DIR"
  rm -rf "$HYPERFRAMES_DIR/node_modules"
else
  echo "→ HyperFrames project already exists at $HYPERFRAMES_DIR (skipping copy)"
fi

mkdir -p "$HYPERFRAMES_DIR/public/audio"
mkdir -p "$HYPERFRAMES_DIR/public/screens"
mkdir -p "$HYPERFRAMES_DIR/public/imagery"
mkdir -p "$HYPERFRAMES_DIR/public/fonts"

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

(
  cd "$HYPERFRAMES_DIR"
  node scripts/generate-data.mjs
)

echo ""
echo "✓ Project initialized at $PROJECT_DIR"
echo ""
echo "Next steps:"
echo "  1. Skill writes design tokens to $HYPERFRAMES_DIR/data/tokens.json"
echo "  2. Skill renders $PROJECT_DIR/out/design-thumbnail.png for Phase 4 review"
echo "  3. Skill writes film data to $HYPERFRAMES_DIR/data/film.json"
echo "  4. Skill places hook audio at $HYPERFRAMES_DIR/public/audio/hook.mp3"
echo "  5. Skill places product screens at $HYPERFRAMES_DIR/public/screens/"
echo "  6. Run scripts/render-hook.sh $PROJECT_DIR to render the hook and cover frame"
