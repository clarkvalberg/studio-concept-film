# Remotion Integration

Used in Phase 4, 6, and 7. This file is the contract between the skill's outputs (script, design tokens, voice selection) and the Remotion template that renders the design thumbnail and final film.

The template lives in `assets/remotion-template/`. The skill copies it into the user's project directory, then injects content via well-defined data files. The template is *generic*; the data is *project-specific*. Keep that boundary clean.

## What the skill does, what the template does

**The skill produces:**
- `<project>/brief.md` — interpreted concept, audience, vision statement
- `<project>/script.md` — final script
- `<project>/motion-board.md` — beat-by-beat visual causality plan
- `<project>/design.md` — design language
- `<project>/voice.json` — voice metadata
- `<project>/remotion/src/data/film.ts` — the consolidated data file the template reads
- `<project>/out/design-thumbnail.png` — Phase 4 style frame rendered from `BrandTokens.ts`
- `<project>/out/cover-frame.png` — Phase 6 frame-0 poster/preview image from the Hook composition
- `<project>/remotion/public/audio/hook.mp3` and `voiceover.mp3` — TTS output
- `<project>/remotion/public/screens/*.png` — product/prototype screens
- `<project>/remotion/public/imagery/*.jpg` — photographic/illustrative imagery
- `<project>/remotion/src/compositions/shared/BrandTokens.ts` — design tokens (only edit if brand differs from default)

**The template provides:**
- Composition definitions (DesignThumbnail, Hook, Full)
- Scene components (ColdOpen, Problem, Insight, ProductWalk, VisionClose, plus shared sub-scenes)
- The composition assembly logic that reads `film.ts` and dispatches to the right scenes

The skill never modifies the canonical template under `assets/remotion-template/` during a project run. It may modify the copied project under `<project>/remotion/` when the approved motion board requires a scene the template cannot express. If the closest existing scene would make the beat static, add a project-specific scene component in the copied project or stop and tell the user the template cannot yet make the film.

## The data contract — `film.ts`

This is the single most important file the skill writes. The template reads it; everything else flows from it.

```typescript
// <project>/remotion/src/data/film.ts

import { FilmData } from '../types';

export const film: FilmData = {
  meta: {
    projectName: 'Signatures.law',
    variant: 'customer-led',    // 'customer-led' | 'insight-led' | 'demo-led'
    totalDuration: 75,          // seconds; sum of section durations
    fps: 30,
    width: 1920,
    height: 1080,
  },

  voice: {
    voiceId: 'nPczCjzI2devNBz1zQrb',
    voiceName: 'Brian',
    hookAudio: '/audio/hook.mp3',          // public path
    fullAudio: '/audio/voiceover.mp3',
  },

  sections: [
    {
      id: 'cold-open',
      sceneType: 'CustomerMoment',          // matches a component in scenes/
      start: 0,
      duration: 8,
      vo: "It's 6:41 PM. The deal is closed. The signing packet is not.",
      sceneProps: {
        visualAction: 'closing PDF stack lands beside the laptop; binder cursor waits',
        beforeState: 'deal is closed, packet state is unresolved',
        afterState: 'the viewer sees the packet as the remaining legal work',
        productProof: 'none yet; this is the problem object',
        motionMode: 'object-flow',
        imagery: 'closing-pdf-stack',
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
      vo: "On a real estate closing, the last mile is a stack of PDFs. Some pages need wet ink and a trip to the recorder. Some can go through DocuSign.",
      sceneProps: {
        visualAction: 'deed, mortgage, FedEx label, DocuSign tab, and email thread split into messy piles',
        beforeState: 'documents appear as one undifferentiated PDF stack',
        afterState: 'the viewer sees conflicting return paths inside the same packet',
        productProof: 'none yet; this is current workflow fragmentation',
        motionMode: 'object-flow',
        screens: ['deed-signature-page', 'mortgage-signature-page', 'fedex-label', 'docusign-tab'],
        treatment: 'desaturated',
        pacing: 'cuts-on-beats',
      },
    },
    {
      id: 'insight',
      sceneType: 'InsightCard',
      start: 22,
      duration: 13,
      vo: "The hard part is not making a packet. It is knowing what each signature page is, where it goes, and leaving a record of that judgment.",
      sceneProps: {
        visualAction: 'messy piles resolve into recording and non-recording lanes while the judgment trail remains visible',
        beforeState: 'signature pages are visually similar but operationally different',
        afterState: 'return path and judgment record become legible',
        productProof: 'classification lanes plus traceable judgment',
        motionMode: 'object-flow',
        kineticPhrase: 'where it goes',
        treatment: 'two-lane-resolution',
        background: 'background',           // references token
      },
    },
    {
      id: 'product-walk',
      sceneType: 'ProductWalk',
      start: 35,
      duration: 30,
      vo: "Signatures.law reads each page, finds the signature pages, and classifies the return path: recording or non-recording. The team reviews the list and generates two files.",
      sceneProps: {
        visualAction: 'documents enter the inbox, fields populate, gaps highlight, deadlines appear',
        beforeState: 'operator must inspect every document manually',
        afterState: 'system has converted documents into structured work',
        productProof: 'document reader, gap detection, deadline flags',
        motionMode: 'product-state-change',
        screens: [
          { src: '/screens/signatures-1-binder.png', label: 'Reads the binder', dwell: 8 },
          { src: '/screens/signatures-2-classification.png', label: 'Classifies return path', dwell: 8 },
          { src: '/screens/signatures-3-outputs.png', label: 'Generates packets', dwell: 8 },
        ],
        microStructure: 'establish-operate-reveal',
      },
    },
    {
      id: 'vision-close',
      sceneType: 'VisionClose',
      start: 65,
      duration: 10,
      vo: "The closing packet becomes more than ready to send. It becomes traceable. Signatures.law.",
      sceneProps: {
        visualAction: 'wet-ink packet, DocuSign packet, checklist, ledger, and manifest settle into a final traceable packet',
        beforeState: 'outputs are separate files',
        afterState: 'outputs read as one defensible closing record',
        productProof: 'two packet PDFs plus checklist, corrections ledger, and manifest',
        motionMode: 'lockup-hold',
        staticOk: true,
        staticReason: 'final brand landing after product causality has already been shown',
        finalImage: 'packet-artifacts',
        logoReveal: 'centered-fade',
        tagline: 'Signatures.law.',
      },
    },
  ],
};
```

### Motion-native scene props

Every section's `sceneProps` should carry the motion-board intent, even if the current scene component only uses some of it:

```typescript
sceneProps: {
  visualAction: 'documents arrive unsorted, then split into legal routing lanes',
  beforeState: 'mixed packet',
  afterState: 'classified paths with outputs',
  productProof: 'wet ink, DocuSign, recording, non-recording labels plus receipt',
  motionMode: 'object-flow', // human-action | object-flow | product-state-change | camera-move | kinetic-type | lockup-hold
  camera: 'slow push then lateral track',
  staticOk: false,
}
```

Avoid `motion: 'static'`. Static holds are allowed only for planned title cards, the insight turn, or the final lockup, and should include `staticOk: true` plus a reason. If a component cannot create the approved action, do not quietly render a held PNG; add a project-specific component in the copied Remotion project.

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

The template exposes three top-level compositions in `src/Root.tsx`:

- **DesignThumbnail** — renders a static 16:9 title-frame / style-frame PNG from `BrandTokens.ts` and lightweight `film.ts` data. Used in Phase 4 before voice audition.
- **Hook** — renders sections `cold-open` and (partially) the next section. Used in Phase 6, and frame 0 is exported as `out/cover-frame.png`.
- **Full** — renders all sections in order. Used in Phase 7 when the user is ready.

All compositions read from `film.ts`. The difference is output format, duration, and which sections they include.

```tsx
// src/Root.tsx (template — do not modify per project)

import { Composition } from 'remotion';
import { film } from './data/film';
import { DesignThumbnail } from './compositions/DesignThumbnail';
import { FullFilm } from './compositions/FullFilm';
import { HookFilm } from './compositions/HookFilm';

const HOOK_DURATION = 15; // seconds

export const Root: React.FC = () => (
  <>
    <Composition
      id="DesignThumbnail"
      component={DesignThumbnail}
      durationInFrames={4 * film.meta.fps}
      fps={film.meta.fps}
      width={film.meta.width}
      height={film.meta.height}
      defaultProps={{}}
    />
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

- `npx remotion still src/index.ts DesignThumbnail ../out/design-thumbnail.png --frame=45` — Phase 4 design thumbnail, usually under 30s after dependencies are installed
- `npx remotion render src/index.ts Hook ../out/hook.mp4` — hook only, ~30s render time for 15s output at 1080p
- `npx remotion still src/index.ts Hook ../out/cover-frame.png --frame=0` — cover/poster frame extracted from the actual hook
- `npx remotion render src/index.ts Full ../out/final.mp4` — full film, ~3–8 minutes for 75s output at 1080p

These are wrapped by `scripts/render-design-thumbnail.sh`, `scripts/render-hook.sh`, and `scripts/render-full.sh` for consistent paths and error messages. `render-hook.sh` produces both `out/hook.mp4` and `out/cover-frame.png`.

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

## Pre-render checklist

Before calling `render-hook.sh` or `render-full.sh`, verify:

- [ ] Audio file exists at the expected path (`public/audio/hook.mp3` or `public/audio/voiceover.mp3`)
- [ ] Audio duration has been measured (`scripts/measure-audio.sh`) and `film.ts` section durations updated to match
- [ ] `meta.totalDuration` equals the sum of all section durations
- [ ] All asset paths in `sceneProps` (screens, imagery) resolve to real files in `public/`
- [ ] `BrandTokens.ts` fonts are either Google Fonts (loaded via `@remotion/google-fonts`) or locally installed
- [ ] `film.ts` compiles without TypeScript errors (run `npx tsc --noEmit`)
- [ ] First section has immediate visual content at frame 0 (no delayed entrance, blank fade-in, loading state, or unreadable tiny UI)

If any item is unchecked, fix it before rendering. A failed render costs 3–10 minutes of compute; a checklist pass costs 30 seconds.

## Post-render review checklist

After render completes, before presenting to user:

- [ ] Watch the rendered video at 1x speed, start to finish
- [ ] Open `out/cover-frame.png` and verify it works as a silent poster frame at 25% size
- [ ] Verify first frame is not blank, glitched, transitional, or showing a loading state
- [ ] Verify VO starts within the first 1–2 seconds (not delayed)
- [ ] Verify the first three seconds reward the cover frame rather than switching to a different idea
- [ ] Verify visual transitions align with VO sentence boundaries (not mid-sentence)
- [ ] Verify product name appears on screen when spoken in VO
- [ ] Verify final frame holds for at least 2 seconds after VO ends
- [ ] Check file size is reasonable (1080p 90s should be 5–15MB at default quality)

If any item fails, fix it in `film.ts` or `BrandTokens.ts` and re-render. Do not present a flawed render to the user with "I'll fix it after you watch" — the first impression of the film is what they evaluate. See `references/audio-visual-sync.md` for diagnosing specific sync failures.
