# Changelog

All notable changes to `studio-video-creator` are documented here.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.2.0] — 2026-05-26

### Added

- Added renderer selection through `<project>/renderer.json`, `--renderer hyperframes|remotion`, and `STUDIO_VIDEO_RENDERER`.
- Restored Remotion as an optional renderer template for React-native video projects.
- Added `references/renderers.md` with selection guidance for HyperFrames, Remotion, and adjacent tools to watch.
- Added `scripts/preview.sh` and renderer-aware routing for thumbnail, hook, full render, and voiceover helpers.

### Changed

- Kept HyperFrames as the default renderer while making script output paths and docs renderer-aware.
- Expanded CI/template checks to cover HyperFrames linting, Remotion typechecking, and Remotion scaffold smoke coverage.

---

## [1.1.0] — 2026-05-26

### Changed

- Replaced the Remotion render template with a HyperFrames HTML/CSS/GSAP template.
- Switched the project data contract from `film.ts` and `BrandTokens.ts` to `data/film.json` and `data/tokens.json`.
- Updated scripts, Makefile targets, CI smoke render, installation docs, workflow docs, and examples for HyperFrames and Node.js 22+.

### Removed

- Removed `assets/remotion-template/` and the Remotion npm dependency surface from new projects.

---

## [1.0.7] — 2026-05-25

### Added

- Added a GitHub Pages video page for the Signatures.law example, with a poster frame and playable MP4.

### Changed

- Linked the README and examples documentation to the playable Signatures.law video page before the worked walkthrough.

---

## [1.0.6] — 2026-05-25

### Added

- Added the verified Signatures.law video artifact at the top of the examples page so readers see the film before the walkthrough.

### Changed

- Made Signatures.law the only public worked example until additional real film artifacts are available.
- Updated Signatures.law example documentation to use Brian as the selected voiceover consistently.
- Preserved the Signatures.law reference video in release packages while continuing to exclude generated audio/video outputs.

### Removed

- Removed the fictional second example from public examples and reference material.

---

## [1.0.5] — 2026-05-25

### Added

- Added a Phase 3B motion-board gate so each 5-8 second beat has visible action, before/after state, motion mode, and product proof before design begins.
- Added `references/motion-board.md` and `scripts/check-static-video.sh` for anti-slideshow planning and rendered-hook freeze-span checks.

### Changed

- Removed named legacy-video references and softened public-facing README, FAQ, philosophy, and skill language.
- Reframed the public repo as reference/install-only now that issues, pull requests, discussions, projects, and wiki are disabled.
- Updated workflow, Remotion integration, and the worked example docs to include the motion-board artifact.
- Replaced submission-oriented public scaffolding with read-only repository positioning.

### Removed

- Removed external submission and participation templates from the public repo.

### Fixed

- Made `scripts/generate-voiceover.sh` trim VO text without `xargs`, preserving shell behavior for quoted text.

---

## [1.0.4] — 2026-05-25

### Added

- Added cover-frame strategy to the skill workflow, including title-card, product-first, human-moment, and thesis poster-frame archetypes.
- Added `references/cover-frame-strategy.md` with frame-0 guidance, small-size checks, failure modes, and Phase 6 review criteria.
- `scripts/render-hook.sh` now exports `out/cover-frame.png` from the actual Hook composition after rendering `out/hook.mp4`.

### Changed

- Updated Phase 3, Phase 4, and Phase 6 guidance so the opening frame is planned in the script, recorded in `design.md`, and verified from the rendered hook.
- Updated workflow docs, examples, FAQ, Remotion integration notes, and CI smoke coverage for the cover-frame artifact.

---

## [1.0.3] — 2026-05-25

### Changed

- Added a Phase 4 visual source checkpoint before design definition, so users can add screenshots, decks, Figma files, brand guides, reference sites, moodboards, or desired aesthetics before the skill thumbnails a direction.
- Clarified that concept-intake sources may remain product truth while newer design-specific references become design truth.
- Updated workflow docs, examples, and FAQ around the new checkpoint.

### Fixed

- Replaced the voice audition script's Bash associative array with a portable voice-name resolver for better macOS shell compatibility.

---

## [1.0.2] — 2026-05-25

### Added

- Added a Phase 4 `DesignThumbnail` Remotion composition that renders a title-frame / style-frame artifact from the selected design tokens.
- Added `scripts/render-design-thumbnail.sh` and `make design-thumbnail`, producing `<project>/out/design-thumbnail.png`.
- Added CI coverage for the design-thumbnail render before the silent hook smoke render.

### Changed

- Updated the skill workflow so Phase 4 now requires a rendered design thumbnail before voice audition.
- Updated design-language guidance to treat the thumbnail as the aesthetic iteration unit and to re-render it until the user approves.
- Updated examples, workflow docs, Remotion integration docs, and architecture docs to reflect the new thumbnail gate.

---

## [1.0.1] — 2026-05-25

### Changed

- Renamed the public project to **Studio Video Creator**.
- Replaced the README banner and social preview with raster artwork sized for GitHub presentation.
- Updated Transformative Studio references to use the public website positioning instead of invented tagline copy.
- Reframed examples as illustrative walkthroughs rather than unsupported public claims about launched ventures, customer research, or product availability.
- Broadened design-reference guidance from Mobbin-only to Mobbin, Refero, or equivalent UI reference sources.
- Added `agents/openai.yaml` metadata and a dedicated skill icon asset.

### Added

- `.env.example` for local voice-generation setup.
- CI smoke-render job that initializes a temporary project, generates silent audio, renders the hook, and verifies output.

### Fixed

- Updated GitHub issue-template contact links from the old repo name to `studio-video-creator`.
- Excluded nested `node_modules` folders from release packaging.

---

## [1.0.0] — 2026-05-20

The first public release. The skill is feature-complete for its core scope: producing 60–90 second concept films from source material via a seven-phase guided workflow.

### Added

- **SKILL.md** — the operating manual: seven gated phases, "guide like software" philosophy, hard rules, recovery patterns.
- **`references/frameworks.md`** — canonical five-section structure (Cold Open → Problem → Insight → Product Walk → Vision Close) with three variants (customer-led / insight-led / demo-led) and worked structural examples.
- **`references/script-rules.md`** — voice and pacing guidance, word-count budgets per film length, sentence-level craft rules, and the **banned words list** (19 outright bans plus near-banned phrases).
- **`references/voice-shortlist.md`** — eight curated ElevenLabs voices with IDs, personas, and an audience-to-voice matching matrix.
- **`references/design-language.md`** — Mobbin querying patterns, brand extraction guidance, and five direction archetypes (Editorial · Architectural · Documentary · Optimistic · Minimal-luxury).
- **`references/intake-checklist.md`** — per-input-type extraction patterns (briefs, prototypes, decks, URLs, loose descriptions) and the two-sentence summary format.
- **`references/remotion-integration.md`** — full data contract spec between the skill and the Remotion template.
- **`references/example-signatures-law.md`** — a complete worked example using Signatures.law (real estate closing packets).
- **Remotion template** in `assets/remotion-template/`:
  - Eight scene types: `CustomerMoment`, `ProblemFrame`, `InsightCard`, `ProductWalk`, `ProductFrame`, `VisionClose`, `KineticType`, `ScreenCallout`
  - Two compositions: `Hook` (~15s) and `Full` (60–90s)
  - Shared `BrandTokens.ts`, `Typography.tsx`, and `motion.ts` utilities
  - Data contract via `src/data/film.ts` and `src/types.ts`
- **Bash scripts** in `scripts/`:
  - `init-project.sh` — scaffold a new project from the template
  - `audition.sh` — generate ElevenLabs voice audition samples via direct API
  - `generate-voiceover.sh` — full TTS generation from `voice.json` + `script.md`
  - `measure-audio.sh` — audio duration measurement for scene alignment
  - `render-hook.sh` — render the Hook composition
  - `render-full.sh` — render the Full composition
- **Documentation** in `docs/`:
  - `PHILOSOPHY.md` — scope and design principles
  - `WORKFLOW.md` — the seven phases in depth
  - `EXAMPLES.md` — worked walkthroughs
  - `INSTALLATION.md` — install paths and troubleshooting
  - `FAQ.md` — questions people actually ask
- **Repository setup**:
  - MIT `LICENSE`
  - `.editorconfig` for consistency
  - CI workflow that runs `shellcheck` and `tsc`

### Notes on scope

This release is deliberately narrow. The skill produces concept films and nothing else. Marketing ads, social posts, tutorials, recorded demos, and long-form video are explicitly out of scope. See [docs/PHILOSOPHY.md](docs/PHILOSOPHY.md).

### Known limitations

- No browser-only render path (Remotion currently requires Node.js)
- Font fallbacks may shift the typography from intent if licensed display fonts (Söhne, Tiempos, GT Sectra) are not installed locally
- The `audition.sh` script uses the default `eleven_multilingual_v2` model; the more recent `eleven_v3` model is the default in `voice.json` and is preferred when available

---

[1.1.0]: https://github.com/clarkvalberg/studio-video-creator/releases/tag/v1.1.0
[1.0.7]: https://github.com/clarkvalberg/studio-video-creator/releases/tag/v1.0.7
[1.0.6]: https://github.com/clarkvalberg/studio-video-creator/releases/tag/v1.0.6
[1.0.5]: https://github.com/clarkvalberg/studio-video-creator/releases/tag/v1.0.5
[1.0.4]: https://github.com/clarkvalberg/studio-video-creator/releases/tag/v1.0.4
[1.0.3]: https://github.com/clarkvalberg/studio-video-creator/releases/tag/v1.0.3
[1.0.2]: https://github.com/clarkvalberg/studio-video-creator/releases/tag/v1.0.2
[1.0.1]: https://github.com/clarkvalberg/studio-video-creator/releases/tag/v1.0.1
[1.0.0]: https://github.com/clarkvalberg/studio-video-creator/releases/tag/v1.0.0
