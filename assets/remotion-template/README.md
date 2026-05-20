# Concept Film — Remotion Template

This Remotion project is the rendering layer for the `studio-concept-film` skill. The skill scaffolds it into your project directory and populates two files with project-specific content. You typically don't edit this template by hand.

## What gets injected

The skill writes:

- `src/data/film.ts` — script + section timing + voice metadata
- `src/compositions/shared/BrandTokens.ts` — typography, color, motion tokens
- `public/audio/hook.mp3` — TTS for the first ~15 seconds
- `public/audio/voiceover.mp3` — TTS for the full film
- `public/screens/*.png` — product screenshots (paths referenced in `film.ts`)
- `public/imagery/*.jpg` — photographic stills for cold opens / vision close (optional)

The template provides everything else.

## Running locally

```bash
npm install
npx remotion preview            # interactive preview at localhost:3000
npx remotion render Hook out/hook.mp4
npx remotion render Full out/final.mp4
```

Node 18+ required.

## Compositions

- `Hook` — first ~15 seconds (cold open + first beat). Used for fast iteration.
- `Full` — the entire film. Render this only when the hook is dialed in.

Both compositions read `src/data/film.ts` and dispatch each section to the matching scene component via `SceneRenderer`.

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
