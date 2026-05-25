<div align="center">

<img src="docs/images/hero.png" alt="Studio Video Creator" />

<br />

[![License: MIT](https://img.shields.io/badge/License-MIT-1A1614.svg?style=flat-square)](LICENSE)
[![Claude Skill](https://img.shields.io/badge/Claude-Skill-C68B3C.svg?style=flat-square)](https://claude.com/skills)
[![Built with Remotion](https://img.shields.io/badge/Built%20with-Remotion-1A1614.svg?style=flat-square)](https://remotion.dev)
[![Voice: ElevenLabs](https://img.shields.io/badge/Voice-ElevenLabs-1A1614.svg?style=flat-square)](https://elevenlabs.io)
[![Status: v1.0](https://img.shields.io/badge/Status-v1.0-2E6F5E.svg?style=flat-square)](CHANGELOG.md)

**A Claude skill that produces sixty-to-ninety-second concept films for product concepts, studio projects, and early-stage ventures.**

[Quickstart](#quickstart) · [How it works](#how-it-works) · [Philosophy](#philosophy) · [Examples](docs/EXAMPLES.md) · [Docs](docs/)

</div>

<br />

---

## What this is

A Claude skill, not an app. Drop it in, give it source material — a brief, a prototype, a deck, a URL — and tell Claude you want a concept film. Seven phases later, you have a rendered 60–90 second video. The first 15 seconds arrive in two minutes; the full film in eight.

This is the InVision-lineage concept-video tradition, codified into a tool. Voiceover-driven. Prototype-grounded. Insight-led. The kind of film you make at the moment a concept becomes legible — to clarify it for yourself, to show it to an LP, to give an internal team something to rally around, or to anchor a launch.

It is not marketing collateral. It is a thinking artifact rendered as video.

<br />

## Why it exists

> **Concept films are won on recognition, not persuasion.**

The viewer should think *"yes, that's the thing I've been trying to name."* Most generated videos fail this. They sell. They list features. They lean on superlatives. They imitate styles that went stale four years ago.

This skill codifies a specific, durable craft tradition:

- The product is the protagonist's tool, not the protagonist's identity
- The voiceover speaks **to** the viewer, not **at** them
- Real screens, not abstract metaphors
- The music builds; the film lands
- Aspiration is earned through specificity, not asserted through superlatives

It exists because that craft was worth turning into a tool.

<br />

## How it works

<div align="center">
  <img src="docs/images/architecture.svg" alt="Architecture diagram" />
</div>

Seven phases. Each one is a gate.

| # | Phase | What happens | Gate |
|---|---|---|---|
| 1 | **Intake** | Claude reads everything you provide and produces a two-sentence concept summary. | You confirm or correct. |
| 2 | **Three sharp questions** | Audience, single insight, vision statement. Skipped if the source answers them. | Brief assembled. |
| 3 | **Variant + script** | Picks one of three structural variants (customer-led / insight-led / demo-led) and writes a 60–90s script. | Script drafted. |
| 4 | **Design direction** | Extracts the brand from inputs or proposes two named directions grounded in real UI references. | Design locked. |
| 5 | **Voice audition** | Four voices from a curated shortlist of eight, each reading the first 10 seconds. | Voice selected. |
| 6 | **Hook render** | The first ~15 seconds are rendered for fast iteration. | Hook delivered. |
| 7 | **Iterate → full render** | Conversational edits. Then the full film. | Film complete. |

The hook render is the iteration unit. The full render is the publication unit. Going straight to full skips the loop; the skill refuses.

<br />

## Quickstart

### Prerequisites

- **Claude** with skills support (claude.ai, Claude Code, or any Claude environment that loads skills)
- **Node.js 18+** for rendering (Remotion)
- **ElevenLabs API key** or access to the ElevenLabs Player MCP for voiceover

### Install the skill

**Option A — `.skill` file (recommended):**

Download [`studio-video-creator.skill`](https://github.com/clarkvalberg/studio-video-creator/releases) from the latest release and load it into Claude per [these instructions](docs/INSTALLATION.md).

**Option B — clone and link:**

```bash
git clone https://github.com/clarkvalberg/studio-video-creator.git ~/.claude/skills/studio-video-creator
```

(See [INSTALLATION.md](docs/INSTALLATION.md) for environment-specific paths.)

### Make a film

Open Claude. Attach your source material. Say something like:

> *"Make a concept film from this brief and prototype. Audience is institutional LPs."*

That's it. The skill takes it from there.

<br />

## What you get

```
your-project/
├── brief.md           ← interpreted concept, audience, vision
├── script.md          ← final script with section timing
├── design.md          ← visual / motion language
├── voice.json         ← selected ElevenLabs voice
├── remotion/          ← full Remotion project, populated
│   ├── src/
│   └── public/
└── out/
    ├── hook.mp4       ← ~15s · round-one deliverable
    └── final.mp4      ← 60–90s · 1080p · ship-ready
```

Everything is editable. Everything is re-renderable. The Remotion project is yours — hand it to a designer to refine, swap in higher-fidelity screens, change the voice for a different audience. The skill is the starting line, not the finish.

<br />

## The eight voices

A curated ElevenLabs shortlist. Choice paralysis kills the workflow; curation is the product. Claude picks four to audition based on your audience and tone, and surfaces the rest only if you ask.

| Voice | Register | Fit |
|---|---|---|
| **Rachel** | Warm intelligent female | The default — works across most variants |
| **Adam** | Deep grounded male | Gravitas. LP-facing, institutional |
| **Antoni** | Warm conversational male | Peer-to-peer, developer tools |
| **Charlotte** | Emotional intimate female | Customer-led films, healthcare, care services |
| **Brian** | Confident American narrator male | Cinematic, brand-launch register |
| **Lily** | Warm British female | Documentary cadence, editorial sensibility |
| **Daniel** | British authority male | Weighty, regulated industries |
| **Will** | Measured thoughtful male | Insight-led films with a contrarian or sophisticated thesis |

Full personas and matching matrix in [`references/voice-shortlist.md`](references/voice-shortlist.md).

<br />

## The banned words

The skill refuses to ship a script containing these. They are not banned because they are meaningless — they are banned because they are **exhausted**. They no longer carry signal. Using one marks a film as generic before the viewer can even hear the idea.

> `revolutionary` · `game-changing` · `best-in-class` · `cutting-edge` · `next-generation` · `leverage` · `unlock` · `empower` · `seamlessly` · `transformative` *(self-applied)* · `innovative` *(self-applied)* · `synergy` · `holistic` · `robust` · `scalable` *(in pitch context)* · `mission-critical` · `enterprise-grade` · `supercharge` · `AI-powered` *(use a specific verb instead)*

Plus near-banned phrases — *"imagine a world where…"*, *"designed to…"*, *"helps you to…"* — that the skill steers around. The complete list with reasoning lives in [`references/script-rules.md`](references/script-rules.md).

<br />

## Lineage

This skill pays explicit homage to the digital product commercial videos pioneered for SaaS tools roughly 2014–2019. The frameworks are codified taste. Treat them as the actual IP.

The structures and rules in this repo are not theoretical. They are extracted from a body of films that, for a brief period, found a register most software videos have since lost — specifically the InVision concept films, which set the form. Other studios contributed. Most have since drifted toward feature-listing, demo-stitching, or AI slop.

The intent here is to make that register repeatable.

<br />

## Roadmap

The first release stays deliberately narrow: 60–90 second concept films with a gated hook-render loop. The broader `studio-video-creator` direction is a family of short studio-grade product videos built from the same craft system:

- **Concept film** — current format; source material becomes a voiceover-led pitch film
- **Launch teaser** — shorter public-facing reveal for a product or studio project
- **Investor narrative** — LP/fundraising cut with sharper market and thesis beats
- **Demo montage** — screen-forward product walkthrough with less narration
- **Internal alignment film** — strategy narrative for teams before build or launch

New formats should add structure without diluting the existing concept-film workflow.

<br />

## Repository

```
studio-video-creator/
├── SKILL.md                      ← the operating manual (Claude reads this)
├── references/                   ← deep guidance loaded by phase
│   ├── frameworks.md             ← the canonical structure + 3 variants
│   ├── script-rules.md           ← voice, pacing, banned words
│   ├── voice-shortlist.md        ← the 8 voices with IDs and fit notes
│   ├── design-language.md        ← UI references, brand extraction
│   ├── intake-checklist.md       ← what to extract per input type
│   ├── remotion-integration.md   ← file layout, data shape, render specs
│   └── example-harmony.md        ← a complete worked example
├── scripts/                      ← executable helpers
│   ├── init-project.sh
│   ├── audition.sh
│   ├── generate-voiceover.sh
│   ├── render-hook.sh
│   └── render-full.sh
├── assets/
│   └── remotion-template/        ← the rendering layer
│       └── src/
│           ├── Root.tsx
│           ├── compositions/
│           │   ├── HookFilm.tsx
│           │   ├── FullFilm.tsx
│           │   ├── SceneRenderer.tsx
│           │   └── scenes/       ← 8 scene types
│           └── data/film.ts      ← data contract with the skill
└── docs/                         ← philosophy, workflow, examples
```

<br />

## Documentation

- **[Philosophy](docs/PHILOSOPHY.md)** — why this skill exists and what it refuses to be
- **[Workflow](docs/WORKFLOW.md)** — the seven phases, in depth
- **[Examples](docs/EXAMPLES.md)** — worked runs (Harmony and a generic insight-led example)
- **[Installation](docs/INSTALLATION.md)** — environment setup, troubleshooting
- **[FAQ](docs/FAQ.md)** — questions people actually ask

<br />

## Contributing

This repo is opinionated. Contributions that sharpen the opinions are welcome. Contributions that dilute them are not.

See [CONTRIBUTING.md](CONTRIBUTING.md) for the kind of changes that fit and the kind that don't.

<br />

## License

MIT. See [LICENSE](LICENSE).

<br />

## Built inside Transformative Studio

A venture studio for companies that take their craft seriously.

[transformative.studio](https://transformative.studio) · [@transformative](https://twitter.com/transformative)

<br />

<div align="center">

<sub>Made with care. Use it freely. Improve it openly.</sub>

</div>
