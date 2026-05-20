# Remotion Integration

Used in Phase 6 and 7. This file is the contract between the skill's outputs (script, design tokens, voice selection) and the Remotion template that renders the film.

The template lives in `assets/remotion-template/`. The skill copies it into the user's project directory, then injects content via well-defined data files. The template is *generic*; the data is *project-specific*. Keep that boundary clean.

## What the skill does, what the template does

**The skill produces:**
- `<project>/brief.md` — interpreted concept, audience, vision statement
- `<project>/script.md` — final script
- `<project>/design.md` — design language
- `<project>/voice.json` — voice metadata
- `<project>/remotion/src/data/film.ts` — the consolidated data file the template reads
- `<project>/remotion/public/audio/hook.mp3` and `voiceover.mp3` — TTS output
- `<project>/remotion/public/screens/*.png` — product/prototype screens
- `<project>/remotion/public/imagery/*.jpg` — photographic/illustrative imagery
- `<project>/remotion/src/compositions/shared/BrandTokens.ts` — design tokens (only edit if brand differs from default)

**The template provides:**
- Composition definitions (Hook, Full)
- Scene components (ColdOpen, Problem, Insight, ProductWalk, VisionClose, plus shared sub-scenes)
- The composition assembly logic that reads `film.ts` and dispatches to the right scenes

The skill never modifies template source files. If something needs to change in how scenes render, it changes in `BrandTokens.ts` or in `film.ts`. If a scene type doesn't exist for what the script needs, the skill notes it and (in extended use) adds a new scene component to the template.

## The data contract — `film.ts`

This is the single most important file the skill writes. The template reads it; everything else flows from it.

```typescript
// <project>/remotion/src/data/film.ts

import { FilmData } from '../types';

export const film: FilmData = {
  meta: {
    projectName: 'Harmony',
    variant: 'customer-led',    // 'customer-led' | 'insight-led' | 'demo-led'
    totalDuration: 75,          // seconds; sum of section durations
    fps: 30,
    width: 1920,
    height: 1080,
  },

  voice: {
    voiceId: '21m00Tcm4TlvDq8ikWAM',
    voiceName: 'Rachel',
    hookAudio: '/audio/hook.mp3',          // public path
    fullAudio: '/audio/voiceover.mp3',
  },

  sections: [
    {
      id: 'cold-open',
      sceneType: 'CustomerMoment',          // matches a component in scenes/
      start: 0,
      duration: 8,
      vo: "It's the 14th of the month. Russ has 312 compliance documents on his desk.",
      sceneProps: {
        imagery: 'hand-on-paper-stack',
        composition: 'close-up',
        light: 'warm-tungsten',
        motion: 'slow-push-in',
      },
    },
    {
      id: 'problem',
      sceneType: 'ProblemFrame',
      start: 8,
      duration: 14,
      vo: "Affordable housing in America runs on paperwork. Every unit, every tenant, every month.",
      sceneProps: {
        screens: ['paper-forms', 'spreadsheet-grid', 'tired-office'],
        treatment: 'desaturated',
        pacing: 'cuts-on-beats',
      },
    },
    {
      id: 'insight',
      sceneType: 'InsightCard',
      start: 22,
      duration: 13,
      vo: "The compliance work isn't going away. But the part where humans do it line by line — that's a choice.",
      sceneProps: {
        kineticPhrase: 'a choice',
        treatment: 'clean-shift',
        background: 'background',           // references token
      },
    },
    {
      id: 'product-walk',
      sceneType: 'ProductWalk',
      start: 35,
      duration: 30,
      vo: "Harmony reads the documents. Catches the gaps. Flags the deadlines. Russ doesn't chase paperwork. He runs his portfolio.",
      sceneProps: {
        screens: [
          { src: '/screens/harmony-1-dashboard.png', label: 'Reads the documents', dwell: 8 },
          { src: '/screens/harmony-2-gaps.png', label: 'Catches the gaps', dwell: 7 },
          { src: '/screens/harmony-3-deadlines.png', label: 'Flags the deadlines', dwell: 7 },
        ],
        microStructure: 'establish-operate-reveal',
      },
    },
    {
      id: 'vision-close',
      sceneType: 'VisionClose',
      start: 65,
      duration: 10,
      vo: "2.3 million affordable units. One operating system. Harmony.",
      sceneProps: {
        finalImage: 'residential-wide',
        logoReveal: 'centered-fade',
        tagline: 'Harmony.',
      },
    },
  ],
};
```

## The token contract — `BrandTokens.ts`

```typescript
// <project>/remotion/src/compositions/shared/BrandTokens.ts

export const tokens = {
  typography: {
    display: { family: 'GT Sectra Display', weight: 700 },
    body:    { family: 'GT America', weight: 400 },
    mono:    { family: 'GT America Mono', weight: 400 },
  },
  color: {
    background: '#F4EFE6',
    ink:        '#1A1614',
    accent:     '#8B4F2B',
    support:    '#C9B89A',
  },
  motion: {
    entrance: 'cubic-bezier(0.16, 1, 0.3, 1)',
    exit:     'cubic-bezier(0.7, 0, 0.84, 0)',
    transition: 'cubic-bezier(0.4, 0, 0.2, 1)',
    durations: { fast: 200, medium: 400, slow: 700, hold: 1500 },
  },
  spacing: {
    unit: 8,        // base unit; scale: 0.5x, 1x, 2x, 4x, 8x
  },
};
```

The template's scene components import `tokens` from this file. Changing a color here changes it everywhere. That's the contract.

## Compositions defined by the template

The template exposes two top-level compositions in `src/Root.tsx`:

- **Hook** — renders sections `cold-open` and (partially) the next section. Used in Phase 6.
- **Full** — renders all sections in order. Used in Phase 7 when the user is ready.

Both compositions read from `film.ts`. The difference is duration and which sections they include.

```tsx
// src/Root.tsx (template — do not modify per project)

import { Composition } from 'remotion';
import { film } from './data/film';
import { FullFilm } from './compositions/FullFilm';
import { HookFilm } from './compositions/HookFilm';

const HOOK_DURATION = 15; // seconds

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
```

## Scene components and what they accept

Each scene component is a self-contained React component that accepts the props defined in its corresponding section's `sceneProps`. The scenes are interchangeable within a slot — a `cold-open` section can use `CustomerMoment`, `InsightCard`, or `ProductFrame` depending on the variant.

**Available scene components (in `src/compositions/scenes/`):**

- `CustomerMoment` — human moment opens (props: imagery, composition, light, motion)
- `InsightCard` — pure typography insight beats (props: kineticPhrase, treatment, background)
- `ProblemFrame` — multi-screen problem montage (props: screens, treatment, pacing)
- `ProductWalk` — three-beat product demonstration (props: screens, microStructure)
- `ProductFrame` — single-screen product showcase (props: screen, callouts, motion)
- `VisionClose` — closing aspirational beat (props: finalImage, logoReveal, tagline)
- `KineticType` — pure typographic moment (props: phrase, treatment, duration)
- `ScreenCallout` — single product screen with callout annotations (props: screen, callouts)

Each scene component reads `tokens` from `BrandTokens.ts` and applies them. The scene defines *layout and motion*; the tokens define *appearance*.

If the script calls for a scene type that doesn't exist, the skill should note this and use the closest fit. The user can extend the template post-hoc; the skill doesn't write new scene components on the fly (that's outside scope).

## Audio sync

The `vo` field in each section is the text spoken during that section. The audio file is rendered once and the template offsets playback to align with section starts.

Two audio assets:
- `public/audio/hook.mp3` — TTS of the first ~15 seconds of script. Used by Hook composition.
- `public/audio/voiceover.mp3` — TTS of the full script. Used by Full composition.

The template's audio playback assumes the TTS aligns with the section timing as written. If the rendered audio is longer than the section budget (common), the skill should:

1. Measure the actual audio length (`scripts/measure-audio.sh`)
2. Update `film.ts` section durations to match
3. Adjust `meta.totalDuration` accordingly
4. Re-render

Don't try to speed up or compress the TTS. Adjust the timing data.

## Render commands

- `npx remotion render Hook out/hook.mp4` — hook only, ~30s render time for 15s output at 1080p
- `npx remotion render Full out/final.mp4` — full film, ~3–8 minutes for 75s output at 1080p

Both wrapped by `scripts/render-hook.sh` and `scripts/render-full.sh` for consistent flags (quality, format, resolution).

## When a render fails

Common causes, in order of frequency:

1. **Missing audio file** — `public/audio/hook.mp3` not generated yet. Run audio generation first.
2. **Malformed `film.ts`** — TypeScript error. Read the error; usually a section is missing a required prop.
3. **Asset path wrong** — screen images referenced in `sceneProps.screens` not in `public/screens/`. Verify all paths exist.
4. **Total duration mismatch** — `meta.totalDuration` doesn't equal the sum of `sections[].duration`. The Remotion config defines duration from `meta.totalDuration`; if it's off, the render truncates or pads.
5. **Font not loaded** — `BrandTokens.ts` references a font face that isn't installed. The template loads common fonts via `@remotion/google-fonts`; if a paid/custom font is needed, the user needs to install it or pick a substitute.

Fix at the source (the data file or token file), not in the template scenes.

## Extending the template (advanced)

If a project genuinely needs a scene type the template doesn't have:

1. Don't modify the template inside the skill's `assets/` directory — that affects every future project
2. Modify it inside the *user's project copy* of the template
3. Note the modification in the project's `README.md` so future runs of the skill don't overwrite

The skill itself should not be writing new scene components on the fly. If you find yourself wanting to, the better move is to pick the closest existing scene type and adjust its props.
