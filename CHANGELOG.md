# Changelog

All notable changes to `studio-concept-film` are documented here.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
- **`references/example-harmony.md`** — a complete worked example using Harmony (LIHTC AI operations).
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
  - `PHILOSOPHY.md` — the manifesto
  - `WORKFLOW.md` — the seven phases in depth
  - `EXAMPLES.md` — worked walkthroughs
  - `INSTALLATION.md` — install paths and troubleshooting
  - `FAQ.md` — questions people actually ask
- **Repository scaffolding**:
  - MIT `LICENSE`
  - `CONTRIBUTING.md` with house style
  - `CODE_OF_CONDUCT.md`
  - `.editorconfig` for consistency
  - GitHub issue templates, PR template, and a CI workflow that runs `shellcheck` and `tsc`

### Notes on scope

This release is deliberately narrow. The skill produces concept films and nothing else. Marketing ads, social posts, tutorials, recorded demos, and long-form video are explicitly out of scope. See [docs/PHILOSOPHY.md](docs/PHILOSOPHY.md).

### Known limitations

- No browser-only render path (Remotion currently requires Node.js)
- Font fallbacks may shift the typography from intent if licensed display fonts (Söhne, Tiempos, GT Sectra) are not installed locally
- The `audition.sh` script uses the default `eleven_multilingual_v2` model; the more recent `eleven_v3` model is the default in `voice.json` and is preferred when available

---

[1.0.0]: https://github.com/clarkvalberg/studio-concept-film/releases/tag/v1.0.0
