---
name: studio-concept-film
description: >
  Produce a studio concept film — a 60–90 second voiceover-driven video that introduces
  a product concept, studio project, or early-stage venture. This is the InVision-lineage
  concept pitch genre — prototype-grounded, insight-led, aspirational close. Use whenever
  the user has source material (research, brief, prototype, deck, website) and wants to
  make their concept legible through video. Trigger on phrases like "concept film",
  "concept video", "pitch video", "product concept video", "studio video", "make a video
  about this", "video walkthrough of the concept", "concept pitch", or when the user
  attaches a brief/prototype and asks for video. Use even when the user doesn't say
  "concept film" explicitly — if they have a product or concept and want a short film
  about it, this is the right skill. Not for marketing ads, social posts, tutorials,
  explainer videos, demos of existing apps, or long-form content.
---

# Studio Concept Film

This skill produces a single, well-defined artifact: a **60–90 second concept film** in the InVision-lineage tradition. Voiceover-driven, prototype-grounded, insight-led, aspirational close.

The film is used at the moment a studio concept becomes legible — post-research, pre-build — to frame the idea for an internal team, an LP, a launch audience, or the founder themselves. It is not marketing collateral. It is a thinking artifact rendered as video.

## Philosophy: Guide like software, not chat

The user wants a tool, not a conversation. Behave accordingly:

- **Decide silently where you can.** Variant selection, structural choices, design defaults — make the call, then name it briefly. Do not present menus when you can present a recommendation.
- **Ask only what you genuinely need.** Hard cap: three questions in the entire intake phase. Each must change the output materially. If a question can be answered from the source material, do not ask it.
- **Gate every phase.** Do not advance to script without a legible concept summary. Do not render without a chosen voice. State the gate; don't quiz the user about it.
- **Show progress.** Each phase ends with a short status line ("Concept locked → moving to script") so the user always knows where they are.
- **Withhold options.** Curation is the value-add. The voice list is 8, not 100. The framework variants are 3, not 12. If the user wants more, they ask.
- **Recover gracefully.** Missing prototype? Suggest the minimum surface needed. Vague brief? Restate what you can extract and ask the user to confirm or correct.

## When to use this skill

**Use when:**
- The user has source material (brief, research, prototype, deck, URL, PDF) for a product concept or studio project AND wants a video
- The user is at the "this needs to become legible" moment in a concept's life
- The video's purpose is framing/pitching/introducing — not marketing or tutorial
- The target length is short (60–120s)

**Do not use when:**
- The user wants a long-form video, tutorial, course, ad creative, social post, talking-head, or recorded demo
- The user has no source material and just wants to brainstorm — that's a different mode
- The user explicitly wants something other than the concept-film genre

If unsure, ask one disambiguating question and let the user steer.

## What you produce

By the end of a complete run, the user has, in their project directory:

```
<project>/
├── brief.md           — interpreted concept, audience, vision statement
├── script.md          — final script with section timing
├── design.md          — chosen visual/motion language and brand interpretation
├── voice.json         — selected ElevenLabs voice ID + audition notes
├── remotion/          — full Remotion project, scenes filled with project content
│   ├── package.json
│   ├── src/
│   └── public/
└── out/
    ├── hook.mp4       — first 10–15s rendered (round-one deliverable)
    └── final.mp4      — full film (rendered on explicit request)
```

The hook render is the iteration unit. The full render is the publication unit.

---

## Workflow

The workflow has seven phases. Each phase is a gate. Do not skip ahead.

### Phase 1 — Intake & legibility gate

Receive the user's source material. Inputs may include:

- A brief, research doc, or memo (PDF, MD, DOCX, plaintext)
- A prototype reference (Figma link, deployed URL, screenshots)
- A deck (PPTX, PDF, Keynote export)
- A website URL
- A loose description in the user's own words

**Steps:**

1. Read everything provided. Use `web_fetch` for URLs, the file-reading skill conventions for documents, image analysis for screenshots.
2. Produce a **two-sentence concept summary** — what it is and why it matters. Show this to the user.
3. **Gate:** Ask the user to confirm or correct the summary. Do not proceed until the concept is legible in two sentences. If you cannot summarize the concept in two sentences from the inputs, the video will fail. Tell the user this directly and ask for the missing piece.
4. State what minimum prototype surface the video will need ("To do this concept justice, the prototype should show: the home/landing view, the core ontology screen, and the action moment"). If the prototype provided already covers this, say so. If not, flag the gap — the user can either provide it now or accept that the film will use schematic representations.

End Phase 1 with: `Concept locked. → Phase 2: clarifying questions.`

Read `references/intake-checklist.md` for the full checklist of what to extract from source materials and how to handle each input type.

### Phase 2 — Three sharp questions (and not one more)

Ask at most three questions. Skip any whose answer is already in the source material.

**The three slots:**

1. **Audience + emotional state.** Who watches this, and what state are they in when the film starts? (Examples: "Skeptical LP who's seen 20 pitches this week." "Internal team that needs to believe.") This determines tone.
2. **The single insight.** If the viewer remembers one thing 10 minutes after watching, what is it? Force the answer into one sentence. This becomes the spine.
3. **The vision statement.** "In a world where… / We believe… / What if…" — one sentence the film can land on. If the user is unsure, propose two options from the source material.

If the source material answers any of these, skip the question and state your inference: "I'm reading the audience as institutional LPs. Correct me if not."

End Phase 2 with: `Brief assembled. → Phase 3: structure and script.`

### Phase 3 — Variant selection and script

You have three structural variants. Pick one silently based on the brief.

**Customer-led** — opens on a person living the problem. Use when the concept is grounded in a human moment (mobile medical care, education, housing, services). The viewer enters through empathy.

**Insight-led** — opens on the idea itself. "What if X." Use when the concept's power is conceptual and the human moment is harder to dramatize (B2B tools, infrastructure, platform plays). The viewer enters through curiosity.

**Demo-led** — opens cold on the product, voiceover catches up. Use when the product is visually striking and self-evident. The viewer enters through "wait, what's that."

Read `references/frameworks.md` for the full structural template, beat-by-beat timing, and worked examples per variant.

**Name your choice in one sentence** ("This wants to be customer-led — opening on a real moment with a clinician making a house call"), then write the script.

**Script writing rules — read `references/script-rules.md` before drafting.** Key points:
- 60–90 seconds at standard VO pace ≈ 150–220 words
- Section structure: Cold Open → Problem → Insight → Product Walk → Vision Close
- Each section has a timing budget
- Voice is warm-confident, never salesy, never breathless
- Concrete > abstract. Specific > generic. Verbs > adjectives.
- The product is named explicitly at least once
- The vision close earns the aspiration through what came before

Output the script in `script.md` with timing per section and per beat:

```markdown
## Cold Open (0:00–0:08)
[On-screen: ...]
**VO:** ...

## Problem (0:08–0:22)
...
```

End Phase 3 with: `Script drafted. → Phase 4: design direction.`

### Phase 4 — Design direction

The film has a visual language. You decide it, then show the user.

Two paths:

**If the brand exists** (logo, deployed site, established palette in the inputs): extract the brand. Identify typography, color, tone of imagery, motion sensibility. Document it in `design.md`.

**If the brand does not exist yet** (early concept): propose two directions. Each direction is a one-paragraph description plus three Mobbin references. Use the Mobbin MCP if available to fetch real inspiration screens. Read `references/design-language.md` for how to query Mobbin effectively and how to structure the proposal.

Either way, end with concrete tokens recorded in `design.md`:

- Primary typeface (with weight choices)
- Display typeface (if different)
- Color palette (background, ink, accent, support)
- Motion principle (e.g., "deliberate slow-in, snap-out; nothing bounces; sub-300ms transitions")
- Imagery direction (photographic, illustrated, screen-cap, kinetic typography mix)

These tokens flow into the Remotion template.

End Phase 4 with: `Design locked. → Phase 5: voice audition.`

### Phase 5 — Voice audition

Use the ElevenLabs Player MCP (`ElevenLabs Player:generate_tts`) to play 4 voice samples reading the first ~10 seconds of the script.

**Choose 4 voices from the curated shortlist in `references/voice-shortlist.md`.** Do not present all 8. Match by the audience and tone established in Phase 2:
- Aspirational/cinematic → Adam, Brian, Rachel
- Intimate/human-moment → Charlotte, Antoni
- Authoritative/institutional → Daniel, Lily
- Warm/optimistic → Rachel, Antoni, Lily

Name your reasoning in one line ("Pulling four warm-but-grounded options given this is an LP-facing pitch") then call the TTS tool four times with the first 10–15s of the script and the chosen voice IDs.

After the user picks (or asks for "more options" → surface the remaining shortlist), save the selected voice ID and notes to `voice.json`:

```json
{
  "voice_id": "21m00Tcm4TlvDq8ikWAM",
  "voice_name": "Rachel",
  "model": "eleven_v3",
  "audition_notes": "Chose for warmth without softness; viewer is institutional but the concept is human.",
  "settings": { "stability": 0.5, "similarity_boost": 0.75 }
}
```

End Phase 5 with: `Voice selected. → Phase 6: hook render.`

### Phase 6 — Hook render (round-one deliverable)

This is the critical UX moment. Do NOT render the full 90s film yet. Render only the **first 10–15 seconds** — the cold open plus the first beat. This is the iteration unit.

**Steps:**

1. Run `scripts/init-project.sh` to copy the Remotion template from `assets/remotion-template/` into `<project>/remotion/`.
2. Generate the project's content files — populate scene props, design tokens, script timing — by writing to `<project>/remotion/src/data/`. See `references/remotion-integration.md` for the exact file layout the template expects.
3. Generate the voiceover audio for the hook section via ElevenLabs (full TTS call with the selected voice_id and the hook script). Save to `<project>/remotion/public/audio/hook.mp3`.
4. Run `scripts/render-hook.sh <project>` which calls Remotion to render only the Hook composition.
5. Communicate render time honestly ("This will take ~2–4 minutes depending on hardware"). Don't pretend it's instant.
6. Present `out/hook.mp4` to the user.

End Phase 6 with: `Hook delivered. → Phase 7: iterate or render full.`

### Phase 7 — Iterate, then render full

The default state after Phase 6 is **conversational iteration**. The user will say things like:
- "Punchier open"
- "Swap the voice to something warmer"
- "The second line should land harder"
- "Make the product walk feel slower, more deliberate"
- "Change the accent color to deeper teal"

For each edit, identify the smallest re-render needed (hook only? specific scene? the whole thing?) and execute. Communicate what you're doing in one line.

**When the user is ready** ("looks good, render the whole thing" / "let's go full"):

1. Generate full voiceover audio (`<project>/remotion/public/audio/voiceover.mp3`)
2. Run `scripts/render-full.sh <project>`
3. Communicate the expected time (~5–10 minutes for a 90s film at 1080p)
4. Present `out/final.mp4`

End Phase 7 with: `Film complete. → Files in <project>/.`

---

## Subfile reference map

When you need depth, read the relevant subfile. Do not load these preemptively — load when the phase requires it.

| Subfile | When to read |
|---|---|
| `references/intake-checklist.md` | Phase 1 — comprehensive intake guidance per input type |
| `references/frameworks.md` | Phase 3 — full structural templates, variant deep-dives, worked examples |
| `references/script-rules.md` | Phase 3 — voice, pacing, vocabulary, do/don't, common failure modes |
| `references/design-language.md` | Phase 4 — Mobbin querying, brand extraction, token specification |
| `references/voice-shortlist.md` | Phase 5 — the 8 curated voices with IDs, personas, when to pick each |
| `references/remotion-integration.md` | Phase 6/7 — file layout, data shape, render commands, debugging |
| `references/example-harmony.md` | Anytime — worked example walking through a real concept-film run |

## Scripts and tools

The skill ships with a set of executable scripts in `scripts/`. Use them rather than inventing equivalents.

| Script | Purpose | When to run |
|---|---|---|
| `scripts/init-project.sh <project>` | Scaffold a new project directory (copies Remotion template, installs deps, creates placeholder files) | Start of Phase 6 |
| `scripts/audition.sh --script TEXT --voices NAMES --output DIR` | Generate ElevenLabs voice samples via direct API (fallback when ElevenLabs MCP isn't available). Produces MP3s + an `index.html` audition page. | Phase 5, only if MCP unavailable |
| `scripts/generate-voiceover.sh <project> [--hook-only]` | Generate voiceover MP3 for a project's script using the voice_id in `voice.json`. Use `--hook-only` for hook render. | Phase 6 (hook), Phase 7 (full) |
| `scripts/measure-audio.sh <audio-file>` | Return audio duration in seconds. Use to align scene timing to actual TTS output length. | When debugging audio sync |
| `scripts/render-hook.sh <project>` | Render the Hook composition (first ~15s). | Phase 6 |
| `scripts/render-full.sh <project>` | Render the full ConceptFilm composition. | Phase 7, only after hook approval |

**Environment dependencies for the scripts:**

- `audition.sh`, `generate-voiceover.sh`: require `ELEVENLABS_API_KEY` env var, `curl`, `jq`
- `measure-audio.sh`: requires `ffprobe` (from ffmpeg)
- `render-*.sh`: require Node.js 18+ in `<project>/remotion/`

**Preferred path when ElevenLabs MCP is available** (Clark's environment): use `ElevenLabs Player:generate_tts` for inline audition playback in Phase 5. Use `scripts/generate-voiceover.sh` for the actual MP3 files that feed Remotion (it produces the audio at the path the Remotion template expects).

---

## Critical rules — do not violate

1. **Never produce a full render before a hook render.** The hook is the iteration unit. Going straight to full wastes 10 minutes of compute and slows the loop.
2. **Never present more than 4 voice options at once.** Curation is the product.
3. **Never ask the user a question whose answer is already in the source material.** It signals you didn't read carefully.
4. **Never advance past the legibility gate (Phase 1) without a confirmed two-sentence summary.** Every downstream failure traces back to skipping this gate.
5. **Never produce a script over 220 words for a 90s film.** Voiceover pace is a hard constraint, not a suggestion.
6. **Never use the word "revolutionary," "game-changing," "leverage," "unlock," "synergy," or "best-in-class" in a script.** Read `references/script-rules.md` for the full banned-words list and why.
7. **Always state the chosen variant before writing the script.** One sentence. Lets the user redirect if you've read the brief wrong.
8. **Always name the gate when transitioning phases.** It tells the user where they are and signals confidence in the structure.

## On the InVision lineage — what this skill is paying homage to

The concept-film genre this skill produces traces to the digital product commercial videos made for SaaS tools roughly 2014–2019. The defining qualities:

- The product is the protagonist's tool, not the protagonist's identity
- The voiceover speaks *to* the viewer, not *at* them
- Real screens, not abstract metaphors — viewers should leave knowing what the product looks like
- The music builds; the film lands
- Aspiration is earned through specificity, not asserted through superlatives

This skill exists to make that craft repeatable. The frameworks are codified taste. Treat them with respect; they're the actual IP.

---

## Recovery patterns

**No prototype provided.** Generate schematic representations in the Remotion scenes — clean wireframe-style screens that convey the ontology without pretending to be the real product. Note the constraint in `brief.md`: "Schematic screens used; real prototype to swap in for final render."

**Concept summary fails (Phase 1 gate).** Restate what you can extract and ask: "I can see [X, Y]. I can't tell [the key thing]. What am I missing?" Do not loop in the dark. One direct question, then proceed when answered.

**User wants something the framework can't handle** (e.g., a 5-minute video, an ad, a tutorial). Surface the mismatch in one line: "This wants to be a different format than the concept film — I'm built for ~60–90s pitch films. Want to proceed in this format or switch to something else?"

**Render fails.** Read the Remotion error. Common causes: missing audio file, malformed prop, oversized asset. Fix at the source (the data file), don't fork the template.

**User asks for a voice not in the shortlist.** Offer to add it for this project only, with a one-line caveat: "I'm using a curated shortlist for consistency — happy to use [voice] just for this film. Do you want me to add it to your default shortlist for future runs as well?"

---

That's the operating manual. The depth lives in the subfiles. Read them when each phase asks for it.
