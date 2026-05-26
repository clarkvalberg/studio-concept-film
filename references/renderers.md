# Renderer Selection

The skill supports two local renderers:

- **HyperFrames** — default. Use for most new concept films: HTML/CSS/GSAP, browser-native composition, low setup friction, and direct token/data JSON contracts.
- **Remotion** — use when the project already lives in React, when a team expects React components as the editable artifact, or when an existing Remotion/Lambda workflow matters more than HyperFrames' simpler local HTML surface.

Do not present this as a menu during normal intake. Pick silently unless the user asks, then record the choice in `<project>/renderer.json`.

## How to choose

Default to HyperFrames when:

- The user has no renderer preference
- The deliverable should be easy to inspect as HTML/CSS/JS
- The project needs quick thumbnail/hook iteration in Codex
- The film is mostly type, product surfaces, screenshots, and GSAP-like motion

Choose Remotion when:

- The user explicitly asks for Remotion
- The source project already has React components worth reusing
- The team wants the video artifact to be a React project
- They need mature Remotion infrastructure such as Lambda rendering or an existing render farm

If the user asks about other tools:

- **Motion Canvas** is credible for technical or diagrammatic explainers, especially when code-authored vector motion is the point. This skill does not ship a Motion Canvas template yet.
- **Revideo** is worth watching for code-authored video, but keep it experimental here until the ecosystem and examples are stronger.
- **Creatomate** and **Shotstack** are useful API renderers, not ideal defaults for this skill because the core artifact should remain local, editable, and source-controlled.

## Commands

```bash
scripts/init-project.sh <project> --renderer hyperframes
scripts/init-project.sh <project> --renderer remotion
```

After initialization, all helper scripts read `<project>/renderer.json`:

```bash
scripts/render-design-thumbnail.sh <project>
scripts/generate-voiceover.sh <project> --hook-only
scripts/render-hook.sh <project>
scripts/render-full.sh <project>
```

You can also override for a single command with:

```bash
STUDIO_VIDEO_RENDERER=remotion scripts/render-hook.sh <project>
```

Only do this if the matching renderer project already exists under `<project>/remotion` or `<project>/hyperframes`.
