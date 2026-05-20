#!/usr/bin/env bash
# init-project.sh
#
# Scaffold a new concept film project by copying the Remotion template
# and installing dependencies.
#
# Usage:
#   scripts/init-project.sh <project-directory>
#
# Example:
#   scripts/init-project.sh ~/concepts/harmony

set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <project-directory>"
  echo "Example: $0 ~/concepts/harmony"
  exit 1
fi

PROJECT_DIR="$1"
SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMPLATE_DIR="$SKILL_DIR/assets/remotion-template"

if [ ! -d "$TEMPLATE_DIR" ]; then
  echo "Error: Remotion template not found at $TEMPLATE_DIR"
  exit 1
fi

# Create project directory structure
mkdir -p "$PROJECT_DIR"
mkdir -p "$PROJECT_DIR/out"

# Copy Remotion template if not already present
if [ ! -d "$PROJECT_DIR/remotion" ]; then
  echo "→ Copying Remotion template to $PROJECT_DIR/remotion"
  cp -r "$TEMPLATE_DIR" "$PROJECT_DIR/remotion"

  # Create required public subdirectories
  mkdir -p "$PROJECT_DIR/remotion/public/audio"
  mkdir -p "$PROJECT_DIR/remotion/public/screens"
  mkdir -p "$PROJECT_DIR/remotion/public/fonts"
else
  echo "→ Remotion project already exists at $PROJECT_DIR/remotion (skipping copy)"
fi

# Install dependencies if needed
if [ ! -d "$PROJECT_DIR/remotion/node_modules" ]; then
  echo "→ Installing dependencies (this takes ~1-2 minutes)"
  cd "$PROJECT_DIR/remotion"
  npm install --silent
  cd - > /dev/null
else
  echo "→ Dependencies already installed (skipping npm install)"
fi

# Create placeholder project files the skill will fill in
for f in brief.md script.md design.md; do
  if [ ! -f "$PROJECT_DIR/$f" ]; then
    echo "# $(echo "$f" | sed 's/\.md$//' | tr '[:lower:]' '[:upper:]')" > "$PROJECT_DIR/$f"
    echo "" >> "$PROJECT_DIR/$f"
    echo "_Pending — to be filled by the skill._" >> "$PROJECT_DIR/$f"
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

echo ""
echo "✓ Project initialized at $PROJECT_DIR"
echo ""
echo "Next steps:"
echo "  1. Skill writes the film data to $PROJECT_DIR/remotion/src/data/film.ts"
echo "  2. Skill writes design tokens to $PROJECT_DIR/remotion/src/compositions/shared/BrandTokens.ts"
echo "  3. Skill places voiceover audio at $PROJECT_DIR/remotion/public/audio/hook.mp3"
echo "  4. Skill places product screens at $PROJECT_DIR/remotion/public/screens/"
echo "  5. Run scripts/render-hook.sh $PROJECT_DIR to render the hook"
