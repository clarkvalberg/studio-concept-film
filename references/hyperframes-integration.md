# HyperFrames Integration

Used in Phase 4, 6, and 7. This file is the contract between the skill's outputs
(script, design tokens, voice selection) and the HyperFrames template that renders
the design thumbnail, hook, cover frame, and final film.

The template lives in `assets/hyperframes-template/`. The skill copies it into
the user's project directory, then injects project-specific data through JSON
files. The template is generic; the data is project-specific.

## File Layout

The skill produces:

- `<project>/brief.md` — interpreted concept, audience, vision statement
- `<project>/script.md` — final script
- `<project>/motion-board.md` — beat-by-beat visual causality plan
- `<project>/design.md` — design language
- `<project>/voice.json` — voice metadata
- `<project>/hyperframes/data/film.json` — project, voice, section, timing, and scene data
- `<project>/hyperframes/data/tokens.json` — typography, color, motion, and spacing tokens
- `<project>/hyperframes/data/generated.js` — generated browser data, created by `scripts/generate-data.mjs`
- `<project>/hyperframes/public/audio/hook.mp3` and `voiceover.mp3` — TTS output
- `<project>/hyperframes/public/screens/*.png` — product/prototype screens
- `<project>/hyperframes/public/imagery/*` — photographic or illustrative imagery
- `<project>/out/design-thumbnail.png` — Phase 4 style frame
- `<project>/out/cover-frame.png` — Phase 6 actual frame-0 poster image
- `<project>/out/hook.mp4` — first 10-15 seconds
- `<project>/out/final.mp4` — full film

The template provides:

- `compositions/design-thumbnail.html`
- `compositions/hook.html`
- `compositions/full.html`
- `scripts/studio-composition.js` — deterministic DOM and GSAP timeline builder
- `scripts/generate-data.mjs` — syncs JSON into browser JS and static composition durations

The skill may modify the copied project under `<project>/hyperframes/` when the
approved motion board requires custom scene treatment. Do not modify the
canonical template under `assets/hyperframes-template/` during a project run.

## Data Contract — `film.json`

`film.json` is the single most important project file. The template reads it
through generated browser data.

```json
{
  "meta": {
    "projectName": "Harmony",
    "variant": "customer-led",
    "totalDuration": 75,
    "fps": 30,
    "width": 1920,
    "height": 1080
  },
  "voice": {
    "voiceId": "nPczCjzI2devNBz1zQrb",
    "voiceName": "Brian",
    "hookAudio": "audio/hook.mp3",
    "fullAudio": "audio/voiceover.mp3"
  },
  "sections": [
    {
      "id": "cold-open",
      "sceneType": "CustomerMoment",
      "start": 0,
      "duration": 8,
      "vo": "It's the 14th of the month. Russ has 312 compliance documents on his desk.",
      "sceneProps": {
        "eyebrow": "Cold Open",
        "visualAction": "hand lifts a page; the overfull stack shifts and exposes the workload",
        "beforeState": "paperwork burden is implied",
        "afterState": "paperwork burden is physically visible",
        "productProof": "problem object",
        "motionMode": "human-action",
        "kineticPhrase": "312 documents",
        "screens": []
      }
    }
  ]
}
```

### Motion-Native Scene Props

Every section's `sceneProps` should carry the motion-board intent:

```json
{
  "visualAction": "documents arrive unsorted, then split into routing lanes",
  "beforeState": "mixed packet",
  "afterState": "classified paths with outputs",
  "productProof": "DocuSign, wet-ink, recording, non-recording labels plus receipt",
  "motionMode": "object-flow",
  "staticOk": false
}
```

Avoid `"motionMode": "static"`. Static holds are allowed only for planned title
cards, the insight turn, or the final lockup, and should include `"staticOk":
true` plus a reason.

## Token Contract — `tokens.json`

```json
{
  "typography": {
    "display": { "family": "GT Sectra Display", "weight": 700, "fallback": "Georgia, serif" },
    "body": { "family": "GT America", "weight": 400, "fallback": "system-ui, sans-serif" },
    "mono": { "family": "GT America Mono", "weight": 400, "fallback": "ui-monospace, monospace" }
  },
  "color": {
    "background": "#F4EFE6",
    "ink": "#1A1614",
    "accent": "#8B4F2B",
    "support": "#C9B89A",
    "surface": "#FFF9EF",
    "muted": "#6F675E"
  },
  "motion": {
    "entrance": "power3.out",
    "exit": "power2.in",
    "transition": "power2.inOut",
    "durations": { "fast": 0.25, "medium": 0.45, "slow": 0.75, "hold": 1.5 }
  },
  "spacing": {
    "unit": 8
  }
}
```

HyperFrames uses CSS and GSAP directly, so the token contract is intentionally
plain JSON. The generated composition sets CSS variables from these values and
builds deterministic paused timelines from them.

## Render Commands

The skill scripts wrap these commands:

- `scripts/init-project.sh <project>` — copies `assets/hyperframes-template/` to `<project>/hyperframes/`
- `scripts/render-design-thumbnail.sh <project>` — renders `compositions/design-thumbnail.html` to `<project>/out/design-thumbnail.png`
- `scripts/render-hook.sh <project>` — renders `compositions/hook.html` to `<project>/out/hook.mp4` and exports `<project>/out/cover-frame.png`
- `scripts/render-full.sh <project>` — renders `compositions/full.html` to `<project>/out/final.mp4`

Internally each render runs:

```bash
cd <project>/hyperframes
node scripts/generate-data.mjs
npx --yes hyperframes@0.6.46 lint
npx --yes hyperframes@0.6.46 render --composition compositions/hook.html --output ../out/hook.mp4
```

For preview:

```bash
cd <project>/hyperframes
npx --yes hyperframes@0.6.46 preview
```

Use the Studio URL printed by HyperFrames, usually:

```text
http://localhost:3002/#project/hyperframes
```

## Validation Checklist

Before showing a render:

- [ ] `data/film.json` is valid JSON
- [ ] `data/tokens.json` is valid JSON
- [ ] `meta.totalDuration` equals the intended full film duration
- [ ] Hook audio exists at `hyperframes/public/audio/hook.mp3`
- [ ] Full audio exists at `hyperframes/public/audio/voiceover.mp3` before full render
- [ ] `node scripts/generate-data.mjs` succeeds
- [ ] `npx --yes hyperframes@0.6.46 lint` returns 0 errors
- [ ] `out/design-thumbnail.png`, `out/cover-frame.png`, and rendered MP4s are non-empty

## Common Failures

1. **Invalid JSON** — fix `film.json` or `tokens.json`; do not hand-edit `generated.js`.
2. **Duration mismatch** — update `meta.totalDuration`; `generate-data.mjs` syncs the static HTML durations before render.
3. **Missing audio** — render scripts intentionally fail if the expected audio file is absent.
4. **Missing product screen** — HyperFrames will still render, but the scene loses product proof. Add the screen or revise `sceneProps` honestly.
5. **Text overflow** — run `npx --yes hyperframes@0.6.46 inspect --samples 15` and tighten copy, font size, or layout.
