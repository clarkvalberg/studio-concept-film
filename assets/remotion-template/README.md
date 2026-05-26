# Concept Film — Remotion Template

This Remotion project is the default React rendering layer for the `studio-video-creator` skill. The skill scaffolds this into your project directory and populates two files with project-specific content.

## What gets injected

The skill writes:

- `src/data/film.ts` — script + section timing + voice metadata
- `src/compositions/shared/BrandTokens.ts` — typography, color, motion tokens
- `../out/design-thumbnail.png` — Phase 4 style frame rendered from the tokens
- `../out/cover-frame.png` — Phase 6 frame-0 poster/preview image rendered from the Hook composition
- `public/audio/hook.mp3` — TTS for the first ~15 seconds
- `public/audio/voiceover.mp3` — TTS for the full film
- `public/screens/*.png` — product screenshots (paths referenced in `film.ts`)
- `public/imagery/*.jpg` — photographic stills for cold opens / vision close (optional)

The template provides everything else.

## Running locally

```bash
npm install
npx remotion preview            # interactive preview at localhost:3000
npx remotion still src/index.ts DesignThumbnail ../out/design-thumbnail.png
npx remotion still src/index.ts Hook ../out/cover-frame.png --frame=0
npx remotion render src/index.ts Hook ../out/hook.mp4
npx remotion render src/index.ts Full ../out/final.mp4
```

Node 22+ recommended.

## Compositions

- `DesignThumbnail` — static title-frame / style-frame artifact. Used to approve the aesthetic before voice audition.
- `Hook` — first ~15 seconds (cold open + first beat). Used for fast iteration; frame 0 is exported as the cover/poster frame.
- `Full` — the entire film. Render this only when the hook is dialed in.

The video compositions read `src/data/film.ts` and dispatch each section to the matching scene component via `SceneRenderer`. The thumbnail composition reads `film.ts` plus `BrandTokens.ts` and renders a single representative title frame.

`SceneRenderer` also adds a subtle `MotionFloor` layer to held or placeholder scenes. It is there to prevent dead-slide renders; real project scenes should still carry visible action through their scene props or custom components.

## Scene components

Located in `src/compositions/scenes/`:

| Component | Used for |
|---|---|
| `CustomerMoment` | Opening on a person, place, or lived moment (Customer-led variant) |
| `ProblemFrame` | Multi-screen montage establishing the friction |
| `InsightCard` | Typographic moment landing the conceptual shift |
| `ProductWalk` | Three-beat product demonstration (establish / operate / reveal) |
| `ProductFrame` | Single product screen, held and breathed |
| `ScreenCallout` | Single screen with annotated callouts |
| `KineticType` | Pure typographic moment, no imagery |
| `VisionClose` | Closing aspirational beat with brand mark |

Each scene component reads `tokens` from `BrandTokens.ts` so design changes flow through automatically. Scenes accept their per-section configuration via the `Section.sceneProps` object — see `src/types.ts` for the type contract.

## Extending the template

If a project genuinely needs a scene type that doesn't exist:

1. Add a new component in `src/compositions/scenes/`
2. Register it in `src/compositions/SceneRenderer.tsx`
3. Add its `SceneType` literal to `src/types.ts`

Do this in the project's local copy, not in the skill's master template — otherwise every future skill run will get your project-specific scene.

## Fonts

The template references display, body, and mono families from `BrandTokens.ts`. If a font isn't installed system-wide, Remotion will substitute the configured fallback. For production renders, install the actual fonts or use `@remotion/google-fonts` to load them at build time.

## Troubleshooting

**Render fails with "audio file not found"** — generate the audio first via the skill's `scripts/generate-voiceover.sh`, or set `voice.voiceId` to `null` in `film.ts` to render silently.

**TypeScript errors on `film.ts`** — verify every section has all required `Section` fields (`id`, `sceneType`, `start`, `duration`, `vo`, `sceneProps`).

**Total duration mismatch** — `meta.totalDuration` must equal the sum of all `sections[].duration` values.

**Asset path errors** — anything in `sceneProps.screens` or `sceneProps.screen` must exist at the referenced path under `public/`. Paths are referenced as `/screens/name.png` (Remotion's `staticFile` resolves to `public/`).
