# Workflow

The skill operates as seven phases. Each is a gate. None can be skipped.

This document is the in-depth version of the workflow summary in the README. The canonical instructions Claude follows are in [`../SKILL.md`](../SKILL.md); the reference subfiles in [`../references/`](../references/) hold the deep guidance loaded by phase.

---

## Phase 1 — Intake & legibility gate

**Goal:** Produce a two-sentence concept summary that the user confirms is correct.

**Why this is a gate.** Every downstream failure of a concept film traces back to skipping legibility. If the concept can't be summarized in two clear sentences from the source material, the film will either lie about what the concept is, paper over the ambiguity with style, or fail to land. The gate makes the failure mode visible before any work is wasted.

**What happens:**

1. Claude reads everything provided — briefs, prototypes, decks, URLs, screenshots, descriptions
2. Claude produces a two-sentence summary in the canonical form: *"\[Product\] is \[category\] for \[audience\] that \[function\]. \[What's distinctive — the insight, timing, or structural advantage\]."*
3. Claude asks the user to confirm or correct
4. Claude states the **minimum prototype surface** needed for the film (typically: entry point, core ontology screen, action moment, result state)

**The user can:** confirm, correct one element, or flag that the concept needs more work before the film is made.

**Gate clears when:** the two-sentence summary is locked.

See [`references/intake-checklist.md`](../references/intake-checklist.md) for the comprehensive intake guidance per input type.

<br />

## Phase 2 — Three sharp questions

**Goal:** Fill three specific slots that the source material may not answer.

**The three slots:**

1. **Audience + emotional state** — Who watches this, in what state? "Skeptical LP who's seen 20 pitches this week." "Internal team that needs to believe." Determines tone.
2. **The single insight** — If the viewer remembers one thing 10 minutes after watching, what is it? Forces a one-sentence answer. Becomes the spine.
3. **The vision statement** — One sentence the film can land on. If the user is unsure, Claude proposes two from the source.

**Why three is a hard cap.** Each question must change the output materially. More than three questions and the workflow starts feeling like a form. If the source answers any of the three, the question is skipped and Claude states its inference for confirmation instead.

**Gate clears when:** all three slots have answers (from source or user).

<br />

## Phase 3 — Variant selection and script

**Goal:** Produce a script in the right structural variant for this concept.

**The three variants:**

- **Customer-led** — Opens on a person living the problem. For concepts where the human moment is the energy.
- **Insight-led** — Opens on the idea. For concepts whose power is structural or conceptual.
- **Demo-led** — Opens cold on the product. For concepts where the product is visually striking enough to be the hook.

The skill picks one silently based on signals in the brief, then names the choice in a single sentence so the user can redirect if the read was wrong.

**Script constraints:**

- 60–90 seconds → 150–220 words at standard VO pace
- Five sections: Cold Open → Problem → Insight → Product Walk → Vision Close
- No banned words (see [`references/script-rules.md`](../references/script-rules.md))
- Visual instructions paired with every VO line

**Gate clears when:** the script is drafted and saved to `script.md`.

<br />

## Phase 4 — Design direction

**Goal:** Lock the film's visual and motion language.

**Two paths:**

- **If the brand exists** (live product, established palette): Claude extracts it. Typography, color, motion sensibility, imagery direction.
- **If the brand doesn't exist yet**: Claude proposes two named directions, each with a one-paragraph description and three concrete UI references from Mobbin, Refero, or an equivalent source (Editorial · Architectural · Documentary · Optimistic · Minimal-luxury).

The user picks. The chosen direction is recorded as concrete tokens in `design.md` — typefaces with weights, colors with hex values, motion principles with timing ranges, imagery direction. These tokens flow directly into the Remotion template.

**Gate clears when:** `design.md` exists with concrete tokens.

See [`references/design-language.md`](../references/design-language.md) for UI-reference querying patterns and direction archetypes.

<br />

## Phase 5 — Voice audition

**Goal:** Pick the voice that will narrate the film.

**The mechanics:**

1. Claude picks 4 voices from a curated shortlist of 8, matching the audience and tone established in Phase 2
2. Each voice reads the first ~10 seconds of the script (the Cold Open + start of Problem)
3. The user picks one or asks for more options
4. Selection saved to `voice.json`

The shortlist is hardcoded. Choice paralysis is the enemy; 8 is the maximum that allows meaningful comparison, and 4 is what gets surfaced at audition. The full matching matrix lives in [`references/voice-shortlist.md`](../references/voice-shortlist.md).

If the user wants a voice outside the shortlist, Claude adds it for this project and offers to add it to the default shortlist for future runs.

**Gate clears when:** `voice.json` has a selected `voice_id`.

<br />

## Phase 6 — Hook render

**Goal:** Render the first ~15 seconds for fast iteration.

**This is the critical UX moment.** The skill renders **only the hook** — not the full film. This is the iteration unit. Most edits will happen here anyway; rendering the full film before the hook is approved wastes 7+ minutes per revision.

**What happens:**

1. `scripts/init-project.sh` copies the Remotion template into the project directory and runs `npm install`
2. Claude writes the project-specific `film.ts` and `BrandTokens.ts` from `script.md` and `design.md`
3. Claude generates the hook voiceover via ElevenLabs (Cold Open + first beat of Problem)
4. `scripts/render-hook.sh` renders the Hook composition
5. The user receives `out/hook.mp4`

Render time: ~2–4 minutes.

**Gate clears when:** the hook is delivered to the user.

<br />

## Phase 7 — Iterate, then render full

**Goal:** Refine through conversational edits, then commit to the full render.

**Iteration patterns:**

| User says | Claude updates | Re-renders |
|---|---|---|
| "Punchier open" | `script.md` cold open + new audio | Hook |
| "Swap to a warmer voice" | new audio with different voice ID | Hook |
| "Adjust the accent to deeper teal" | `BrandTokens.ts` | Hook |
| "Slow the product walk" | `film.ts` timing for productWalk | Full (or scene preview) |
| "Replace screen 2" | new file in `public/screens/` | Hook or scene preview |

**Full render trigger:** the user says "render the full thing" / "let's go full" / similar.

**What happens:**

1. Claude generates the full voiceover from the complete `script.md`
2. `scripts/render-full.sh` renders the Full composition
3. The user receives `out/final.mp4`

Render time: ~5–10 minutes for 1080p at 30fps.

**Gate clears when:** the user has the final film.

<br />

## On the gates

The seven gates are not arbitrary friction. Each one catches a specific failure mode:

- **Gate 1** catches concepts that aren't ready to be filmed
- **Gate 2** catches drift between Claude's read and the user's intent
- **Gate 3** catches structure-content mismatch
- **Gate 4** catches generic visual language
- **Gate 5** catches voice-tone mismatch with audience
- **Gate 6** catches expensive re-renders by forcing cheap iteration first
- **Gate 7** catches premature commitment to a film that hasn't been refined

Removing any one gate is technically possible. It makes the skill faster and the output worse. The gates are the craft.
