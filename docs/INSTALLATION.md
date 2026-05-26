# Installation

Three ways to install, depending on how you use Claude.

---

## Prerequisites

Before installing, make sure you have:

- **Claude** with skills support — claude.ai with skills enabled, Claude Code, Cowork, or any Claude environment that loads `SKILL.md` files
- **Node.js 22+** — for local rendering
- **One of:**
  - The **ElevenLabs Player MCP** connected to your Claude environment (preferred — auditions play inline in the chat), or
  - An **ElevenLabs API key** with TTS access (works in any environment that can run bash scripts)

Optional but recommended:

- **Mobbin, Refero, or another UI reference source** — for design-direction inspiration in Phase 4
- **`ffmpeg`** — for audio duration measurement and static-video checks
- **`jq`** — used by the helper bash scripts for JSON parsing

Renderer note:

- Remotion is the default renderer for new projects.
- HyperFrames is also included for HTML/CSS/GSAP video projects: `scripts/init-project.sh <project> --renderer hyperframes`.

---

## Option 1 — Install the `.skill` file (recommended)

The packaged `.skill` file is the easiest path. It contains the entire skill in a single distributable.

1. Download the latest `studio-video-creator.skill` from the [Releases](https://github.com/clarkvalberg/studio-video-creator/releases) page
2. Load it into Claude:
   - **claude.ai:** Settings → Skills → "Add skill" → upload the file
   - **Claude Code:** drop it in `~/.claude/skills/`
   - **Other environments:** consult your environment's skill loading docs

3. Trigger the skill by bringing source material and asking for a concept film. See [README.md → Quickstart](../README.md#quickstart).

---

## Option 2 — Clone the repo

Useful if you want to read the source, install from Git, or adapt the skill in your own fork.

```bash
# Clone into your Claude skills directory
git clone https://github.com/clarkvalberg/studio-video-creator.git ~/.claude/skills/studio-video-creator

# Verify the skill is picked up
ls ~/.claude/skills/studio-video-creator/SKILL.md
```

Skill directory locations by environment:

| Environment | Default path |
|---|---|
| Claude Code | `~/.claude/skills/` |
| Cowork | `~/cowork/skills/` |
| Custom Claude API setup | wherever your runner is configured to load skills |

---

## Option 3 — Project-local install

For one-off use without registering the skill globally:

```bash
cd ~/projects
git clone https://github.com/clarkvalberg/studio-video-creator.git
cd studio-video-creator

# Point Claude at this directory for the session
```

In Claude Code, you can launch with a specific skill path:

```bash
claude --skill ./studio-video-creator "Make a concept film from these inputs..."
```

---

## Setting up ElevenLabs

The skill auditions and generates voiceover via ElevenLabs. Two paths:

### Path A — ElevenLabs Player MCP (preferred)

If your Claude environment has the [ElevenLabs Player MCP](https://elevenlabs.io/docs/mcp) connected, audition samples play inline in chat. No API key needed in your shell.

In Phase 5, Claude will call `ElevenLabs Player:generate_tts` four times with the chosen voice IDs.

### Path B — Direct API via shell

If you don't have the MCP, you can use the bundled `scripts/audition.sh` directly. Set an environment variable:

```bash
export ELEVENLABS_API_KEY="sk_..."
```

Get a key at [elevenlabs.io/app/settings/api-keys](https://elevenlabs.io/app/settings/api-keys).

You can put the export in your shell profile (`~/.zshrc`, `~/.bashrc`) to make it persistent.

For projects, the skill also reads `voice.json` for the chosen voice settings — see [`references/voice-shortlist.md`](../references/voice-shortlist.md) for the audition mechanics.

---

## Verifying the install

Run the skill against a trivial test prompt. In Claude, attach any product brief or paste a few sentences describing a hypothetical product, then say:

> *"Make a concept film from this. Audience is investors. Use schematic screens if needed."*

You should see Phase 1 begin within seconds — Claude reads the source, produces a two-sentence summary, and asks you to confirm.

If Claude does not recognize the request as a concept-film job, the skill is not being loaded. Check:

- The `SKILL.md` file exists at the root of the skill directory
- The skill directory is in a path Claude scans for skills
- The skill's `description` field in `SKILL.md` frontmatter matches the kind of phrasing you used

---

## Troubleshooting

### "Renderer fails"

Most common causes:

- **Node or FFmpeg is missing** — run `node -v` and `ffmpeg -version`; local rendering requires Node.js 22+ and FFmpeg
- **Missing audio file** — Phase 6 expects `public/audio/hook.mp3`; Phase 7 expects `public/audio/voiceover.mp3`
- **Missing screenshots** — paths in the renderer data file must exist in `public/screens/`
- **Font not found** — install the referenced fonts system-wide, or change them to system fonts
- **Remotion dependencies are missing** — the scripts install them on first render; if that fails, run `npm ci` in `<project>/remotion`

### "Audio is out of sync"

Voiceover length must match scene duration in the renderer data file. Use `scripts/measure-audio.sh <file>.mp3` to get the actual duration, then update the scene's `duration` field accordingly.

### "The skill doesn't trigger"

The skill's `description` is the triggering field. Make sure your request includes concept-film signal words ("concept film," "concept video," "pitch video," "make a video about this concept," etc.). Or attach source material and explicitly ask for a video.

### "ElevenLabs returns 401"

API key is missing, invalid, or doesn't have TTS access. Verify at [elevenlabs.io/app/settings/api-keys](https://elevenlabs.io/app/settings/api-keys).

### "I want to extend the skill"

This public repo is available for reference and installation, but is not accepting external issues or pull requests. To extend the skill, fork it and work in either `references/` (frameworks, rules) or the renderer template under `assets/`.
