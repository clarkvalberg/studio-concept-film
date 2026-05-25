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

# Create project directory structure
mkdir -p "$PROJECT_DIR"
mkdir -p "$PROJECT_DIR/out"

scaffold_from_template() {
  echo "→ Copying Remotion template to $PROJECT_DIR/remotion"
  cp -r "$TEMPLATE_DIR" "$PROJECT_DIR/remotion"
  rm -rf "$PROJECT_DIR/remotion/node_modules"

  mkdir -p "$PROJECT_DIR/remotion/public/audio"
  mkdir -p "$PROJECT_DIR/remotion/public/screens"
  mkdir -p "$PROJECT_DIR/remotion/public/imagery"
  mkdir -p "$PROJECT_DIR/remotion/public/fonts"
}

scaffold_from_scratch() {
  echo "→ Template directory not found at $TEMPLATE_DIR"
  echo "→ Scaffolding a minimal Remotion project from scratch"

  local REMOTION_DIR="$PROJECT_DIR/remotion"
  mkdir -p "$REMOTION_DIR"
  mkdir -p "$REMOTION_DIR/src/data"
  mkdir -p "$REMOTION_DIR/src/compositions/scenes"
  mkdir -p "$REMOTION_DIR/src/compositions/shared"
  mkdir -p "$REMOTION_DIR/public/audio"
  mkdir -p "$REMOTION_DIR/public/screens"
  mkdir -p "$REMOTION_DIR/public/imagery"
  mkdir -p "$REMOTION_DIR/public/fonts"

  cd "$REMOTION_DIR"

  echo "→ Initializing package.json"
  npm init -y > /dev/null

  echo "→ Installing Remotion and dependencies (this takes ~1-2 minutes)"
  npm install --save-exact --silent \
    remotion \
    @remotion/cli \
    @remotion/google-fonts \
    react \
    react-dom \
    typescript \
    @types/react

  cat > "$REMOTION_DIR/tsconfig.json" << 'TSCONFIG'
{
  "compilerOptions": {
    "target": "ES2018",
    "module": "ESNext",
    "moduleResolution": "node",
    "jsx": "react-jsx",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "lib": ["DOM", "ES2018"]
  },
  "include": ["src"]
}
TSCONFIG

  cat > "$REMOTION_DIR/remotion.config.ts" << 'CFG'
import { Config } from '@remotion/cli/config';

Config.setVideoImageFormat('jpeg');
Config.setConcurrency(1);
CFG

  cat > "$REMOTION_DIR/src/index.ts" << 'INDEX'
import { registerRoot } from 'remotion';
import { Root } from './Root';

registerRoot(Root);
INDEX

  cat > "$REMOTION_DIR/src/Root.tsx" << 'ROOT'
import React from 'react';
import { Composition } from 'remotion';
import { film } from './data/film';
import { FullFilm } from './compositions/FullFilm';
import { HookFilm } from './compositions/HookFilm';

const HOOK_DURATION = 15;

export const Root: React.FC = () => (
  <>
    <Composition
      id="Hook"
      component={HookFilm}
      durationInFrames={HOOK_DURATION * film.meta.fps}
      fps={film.meta.fps}
      width={film.meta.width}
      height={film.meta.height}
      defaultProps={{}}
    />
    <Composition
      id="Full"
      component={FullFilm}
      durationInFrames={film.meta.totalDuration * film.meta.fps}
      fps={film.meta.fps}
      width={film.meta.width}
      height={film.meta.height}
      defaultProps={{}}
    />
  </>
);
ROOT

  cat > "$REMOTION_DIR/src/types.ts" << 'TYPES'
export type Variant = 'customer-led' | 'insight-led' | 'demo-led';

export interface FilmMeta {
  projectName: string;
  variant: Variant;
  totalDuration: number;
  fps: number;
  width: number;
  height: number;
}

export interface FilmVoice {
  voiceId: string;
  voiceName: string;
  hookAudio: string;
  fullAudio: string;
}

export interface FilmSection {
  id: string;
  sceneType: string;
  start: number;
  duration: number;
  vo: string;
  sceneProps: Record<string, unknown>;
}

export interface FilmData {
  meta: FilmMeta;
  voice: FilmVoice;
  sections: FilmSection[];
}
TYPES

  cat > "$REMOTION_DIR/src/data/film.ts" << 'FILM'
import { FilmData } from '../types';

// Placeholder — skill will overwrite with project content during Phase 6.
export const film: FilmData = {
  meta: {
    projectName: 'Untitled',
    variant: 'insight-led',
    totalDuration: 15,
    fps: 30,
    width: 1920,
    height: 1080,
  },
  voice: {
    voiceId: '',
    voiceName: '',
    hookAudio: '/audio/hook.mp3',
    fullAudio: '/audio/voiceover.mp3',
  },
  sections: [],
};
FILM

  cat > "$REMOTION_DIR/src/compositions/shared/BrandTokens.ts" << 'TOKENS'
// Placeholder design tokens — skill will overwrite during Phase 4 → Phase 6.
export const tokens = {
  typography: {
    display: { family: 'Inter', weight: 700 },
    body: { family: 'Inter', weight: 400 },
    mono: { family: 'JetBrains Mono', weight: 400 },
  },
  color: {
    background: '#0B0B0B',
    ink: '#F5F5F5',
    accent: '#7C9CFF',
    support: '#3A3A3A',
  },
  motion: {
    entrance: 'cubic-bezier(0.16, 1, 0.3, 1)',
    exit: 'cubic-bezier(0.7, 0, 0.84, 0)',
    transition: 'cubic-bezier(0.4, 0, 0.2, 1)',
    durations: { fast: 200, medium: 400, slow: 700, hold: 1500 },
  },
  spacing: {
    unit: 8,
  },
};
TOKENS

  cat > "$REMOTION_DIR/src/compositions/HookFilm.tsx" << 'HOOK'
import React from 'react';
import { AbsoluteFill } from 'remotion';
import { tokens } from './shared/BrandTokens';

// Placeholder composition — skill will fill in scene routing during Phase 6.
export const HookFilm: React.FC = () => (
  <AbsoluteFill style={{ background: tokens.color.background, color: tokens.color.ink }} />
);
HOOK

  cat > "$REMOTION_DIR/src/compositions/FullFilm.tsx" << 'FULL'
import React from 'react';
import { AbsoluteFill } from 'remotion';
import { tokens } from './shared/BrandTokens';

// Placeholder composition — skill will fill in scene routing during Phase 6.
export const FullFilm: React.FC = () => (
  <AbsoluteFill style={{ background: tokens.color.background, color: tokens.color.ink }} />
);
FULL

  # Placeholder scene files — skill fills these in during Phase 6.
  for scene in CustomerMoment InsightCard ProblemFrame ProductWalk ProductFrame VisionClose KineticType ScreenCallout; do
    cat > "$REMOTION_DIR/src/compositions/scenes/${scene}.tsx" << SCENE
import React from 'react';
import { AbsoluteFill } from 'remotion';

export const ${scene}: React.FC<Record<string, unknown>> = () => (
  <AbsoluteFill />
);
SCENE
  done

  # Update package.json to use ESM and add remotion scripts.
  node -e "const fs=require('fs');const p='./package.json';const j=JSON.parse(fs.readFileSync(p));j.type='module';j.scripts=Object.assign({},j.scripts,{start:'remotion studio src/index.ts',build:'remotion render'});fs.writeFileSync(p,JSON.stringify(j,null,2));"

  cd - > /dev/null
}

# Copy Remotion template if not already present
if [ ! -d "$PROJECT_DIR/remotion" ]; then
  if [ -d "$TEMPLATE_DIR" ]; then
    scaffold_from_template
  else
    scaffold_from_scratch
  fi
else
  echo "→ Remotion project already exists at $PROJECT_DIR/remotion (skipping copy)"
fi

# Install dependencies if needed (template path — scratch path already installed)
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
