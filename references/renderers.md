# Renderer Selection

The skill supports two local renderers:

- **Remotion** — default and recommended. Use for most new concept films: mature React composition, stronger component reuse, better ecosystem depth, and a more reliable editable artifact for teams.
- **HyperFrames** — optional. Use when an HTML/CSS/GSAP project is specifically preferable, or when the user asks for browser-native composition without React.

Do not present this as a menu during normal intake. Pick silently unless the user asks, then record the choice in `<project>/renderer.json`.

## How to choose

Default to Remotion when:

- The user has no renderer preference
- The film needs stronger authored scenes, richer component logic, or more reliable product-screen choreography
- The project may be handed to engineers or designers who already work in React
- The team may later want Remotion infrastructure such as Lambda rendering or an existing render farm

Choose HyperFrames when:

- The user explicitly asks for HyperFrames
- The deliverable should be plain HTML/CSS/JS rather than React
- The film is mostly type, product surfaces, screenshots, and GSAP-like motion
- Low-dependency browser-native composition matters more than Remotion's ecosystem maturity

If the user asks about other tools:

- **Motion Canvas** is credible for technical or diagrammatic explainers, especially when code-authored vector motion is the point. This skill does not ship a Motion Canvas template yet.
- **Revideo** is worth watching for code-authored video, but keep it experimental here until the ecosystem and examples are stronger.
- **Creatomate** and **Shotstack** are useful API renderers, not ideal defaults for this skill because the core artifact should remain local, editable, and source-controlled.

## Commands

```bash
scripts/init-project.sh <project> --renderer remotion
scripts/init-project.sh <project> --renderer hyperframes
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
STUDIO_VIDEO_RENDERER=hyperframes scripts/render-hook.sh <project>
```

Only do this if the matching renderer project already exists under `<project>/remotion` or `<project>/hyperframes`.
