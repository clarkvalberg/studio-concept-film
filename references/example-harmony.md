# Example — Harmony (Customer-led)

A complete worked example of the skill applied to a real venture studio concept: Harmony, an AI-native operating system for affordable housing operators handling LIHTC compliance work. Read this when running the skill for the first time, or anytime the abstractions in `frameworks.md` need grounding.

The example shows what happens at each phase — what the user said, what the skill produced, what got asked, what got decided silently.

## What the user provided

The user dropped three files and a Figma link:

1. `harmony-brief.md` — a one-page concept memo
2. `harmony-research-summary.pdf` — synthesis of 12 LIHTC operator interviews
3. `harmony-pitch-v3.pdf` — partner-facing slide deck (8 slides)
4. Figma link to a prototype with 6 screens

User's prompt: *"Let's make a concept film for Harmony. Files attached, plus the Figma."*

## Phase 1 — Intake & legibility gate

The skill read all four inputs. Notable extractions:

- From the brief: "Affordable housing operators spend 40% of their time on compliance paperwork instead of running their portfolios."
- From the research: a recurring quote — "I got into this work for the mission, and I spend my days on filing."
- From the deck: the founder, Russ, has 22 years in the space. The product is positioned not as compliance software but as "operating system."
- From the Figma: six screens — Dashboard, Property Detail, Document Inbox, Compliance Calendar, Tenant Recertification flow, Alert center.

**Two-sentence summary the skill produced:**

> Harmony is an AI-native operating system for affordable housing operators that handles LIHTC compliance work end-to-end.
>
> Affordable housing runs on paperwork that crushes the operators trying to deliver the mission; Harmony makes the compliance work disappear into the background so operators can run their portfolios instead of their filing cabinets.

**What the skill said to the user:**

> Here's the concept as I'm reading it from the materials:
>
> *Harmony is an AI-native operating system for affordable housing operators that handles LIHTC compliance work end-to-end. Affordable housing runs on paperwork that crushes the operators trying to deliver the mission; Harmony makes the compliance work disappear into the background so operators can run their portfolios instead of their filing cabinets.*
>
> Three pillars I'm reading:
> 1. The compliance work is real and not going away — Harmony doesn't fight that, it absorbs it
> 2. The product is positioned as operating system, not point tool
> 3. The audience is operators with mission-driven motivation, not back-office staff
>
> One thing I want to confirm: is Russ the user persona for the film, or is he the founder we're behind-the-scenes of? The brief uses his name both ways.
>
> **Concept locked when you confirm.** → Phase 2 next.

User: "Russ is the user persona. He's an operator at a portfolio in Brooklyn. Confirm everything else."

Skill: *Concept locked. → Phase 2.*

## Phase 2 — Three sharp questions

The skill noted what was already answerable from the source material:
- Audience: implied by deck — institutional LPs and prospective operator-customers
- Vision: extractable from brief — "compliance becomes invisible"
- Single insight: less clear from materials

So the skill asked only what it couldn't infer, framing inferences explicitly:

> Three things to nail before we write:
>
> 1. I'm reading the audience as **two-headed**: institutional LPs (this is partner deck material) and prospective operator-customers (since the film could also live on a launch page). The film will be tuned for both, but with primary lean toward LPs since you're in fundraising mode. Correct me if not.
>
> 2. **The single take-away.** If a viewer remembers one thing 10 minutes later, what is it? My read from the brief is *"affordable housing operators are working too hard on the wrong things."* Sharper?
>
> 3. **The vision.** "If Harmony wins, in three years the world looks like ___." From the brief I'd propose: *"2.3 million affordable units running on one operating system, with operators back to running portfolios."* Want me to use that or sharpen?

User: "1: yes. 2: better — 'operators got into this for the mission and are drowning in paperwork; that's a choice we're making.' 3: use yours."

The skill captured this into `brief.md` and moved on.

## Phase 3 — Variant selection and script

**The skill's variant decision (named in one sentence):**

> This wants to be **customer-led** — opening on Russ. The take-away you sharpened is fundamentally about a person's experience, and the LP audience will be moved more by a real operator than by a thesis statement.

The skill then produced the script:

```markdown
# Harmony — Concept Film Script

**Variant:** Customer-led
**Target runtime:** 1:18
**Word count:** 192 (155 wpm → 1:14, with ~4s buffer for holds and transitions)

## Cold Open (0:00–0:08)

**[On-screen:** Close-up. Hands sorting through a thick stack of paper files on
a desk. Warm tungsten light. The stack is taller than it should be.**]**

**VO:** It's the 14th of the month. Russ has 312 compliance documents on his desk.


## Problem (0:08–0:22)

**[On-screen:** Quick cuts. A spreadsheet view. A paper form half-filled. A
tired office at end of day. A clock at 9:47 PM.**]**

**VO:** Affordable housing in America runs on paperwork. Every unit. Every
tenant. Every month. Russ runs a 400-unit portfolio in Brooklyn. He got into
this work for the mission. He spends his days on filing.


## Insight (0:22–0:35)

**[On-screen:** Shift to clean interface. The Harmony product is on Russ's
laptop — single screen, breathing room. Kinetic type on "a choice."**]**

**VO:** The compliance work isn't going away. But the part where humans do it,
line by line, page by page — that's a choice. Not a requirement.


## Product Walk (0:35–1:05)

**[On-screen:** Three product moments, each ~9 seconds.
1. Document Inbox — papers flow in, Harmony reads them, structured data populates
2. Compliance Calendar — deadlines auto-appear with confidence indicators
3. Alerts center — Russ taps one alert, sees the recertification needed, approves**]**

**VO:** Harmony reads the documents. Catches the gaps. Flags the deadlines.
Surfaces what needs attention, when. Russ doesn't chase paperwork anymore.
He runs his portfolio.


## Vision Close (1:05–1:18)

**[On-screen:** Wide shot of a residential street in Brooklyn. Cut to product
mark, centered. Hold for 3 seconds.**]**

**VO:** 2.3 million affordable units in this country.
One operating system.
Harmony.
```

Then asked: *"Does this script feel like the film you're making? Tell me what to sharpen, or say 'good, continue.'"*

User: "Tighten 'Russ runs a 400-unit portfolio in Brooklyn.' Combine with the next line. Keep everything else."

Skill applied the edit:

> Russ runs a 400-unit portfolio in Brooklyn — got into this work for the mission, spends his days on filing.

User: "Good, continue."

## Phase 4 — Design direction

The skill noted: Harmony has an emerging brand (visible in the Figma — typography choices, a specific muted teal accent, paper-warm backgrounds). Path 1 (extract) applies.

**What got extracted from Figma:**

- Display: GT Sectra Display, weight 700
- Body: GT America, weight 400 (occasionally 500 for emphasis)
- Background: #F4EFE6 (warm off-white, "paper")
- Ink: #1A1614 (deep, slightly warm black — not pure)
- Accent: #2E6F5E (Harmony teal — already in the Figma's accent role)
- Support: #C9B89A (muted clay — secondary marks)

**Motion language proposed:**

- Slow editorial — long ease-outs (700ms), generous holds (1.5s minimum on text), no bouncing
- Two kinetic typography moments: the phrase "a choice" in the insight section, and the closing line "Harmony."

**Imagery:**

- Product screens treated as artifacts — large but with breathing room around them
- The cold open and the wide shot at close are photographic (real footage or licensed stills — the skill noted to the user that these need to be sourced or filmed)
- Kinetic type used sparingly — twice in the film

The skill output `design.md` with these tokens and asked: *"This matches what's in Figma. Want any adjustments?"*

User: "Make the accent a touch more saturated — #1F6354 instead."

Skill updated.

## Phase 5 — Voice audition

The skill picked four voices for the audition:

1. **Rachel** — warm observational; default for customer-led
2. **Charlotte** — intimate, present; could elevate the cold open
3. **Antoni** — warm-accessible; matches the human-moment register
4. **Daniel** — institutional counterpoint; LPs are the audience

The skill named its reasoning:

> Pulling four for the audition. Three lean warm (Rachel, Charlotte, Antoni — different shades of warmth) and one institutional (Daniel) as a counterpoint, since the LP audience might land harder with measured authority.

The skill called `ElevenLabs Player:generate_tts` four times, each reading the first 13 seconds of the script (Cold Open + first line of Problem).

User listened, said: "Rachel. She lands 'spends his days on filing' without melodrama."

Skill saved to `voice.json`:

```json
{
  "voice_id": "21m00Tcm4TlvDq8ikWAM",
  "voice_name": "Rachel",
  "model": "eleven_v3",
  "audition_notes": "Warm-observational; lands the empathy without performing it.",
  "alternates_considered": ["Charlotte", "Antoni", "Daniel"],
  "settings": { "stability": 0.5, "similarity_boost": 0.75, "style": 0.3 }
}
```

## Phase 6 — Hook render

The skill ran `scripts/init-project.sh harmony/` to copy the template, wrote `data/film.ts` with Cold Open + Problem section data, generated the hook TTS audio (`public/audio/hook.mp3`), and ran `scripts/render-hook.sh harmony/`.

Render took ~90 seconds. Output: `harmony/out/hook.mp4` — 13 seconds, showing Cold Open through the first line of Problem.

The skill presented it: *"Hook delivered. What's working? What's off?"*

## Phase 7 — Iteration

User watched the hook and gave three notes:

1. "The hands feel a little staged. Can we get more candid feel?"
2. "Rachel's pacing is good but the gap between 'desk' and 'Affordable housing' is a beat too long."
3. "Love the kinetic 'a choice' moment in the script — can we render that next?"

The skill responded:

> Three quick fixes:
>
> 1. Updating the Cold Open scene's `imagery` prop from `'hand-on-paper-stack'` to `'hand-candid-pickup'` — uses a different reference still that breaks the symmetry.
> 2. Trimming the TTS gap by adjusting `<break time="0.4s"/>` to `<break time="0.2s"/>` in the SSML for the section boundary.
> 3. Re-rendering with the insight section included — will be ~25 seconds, ~2 minutes render.

Re-rendered. User watched. "Good. Let's go full."

Skill ran `scripts/render-full.sh harmony/`, generated the full voiceover audio, rendered the 78-second film, output `harmony/out/final.mp4`.

> Film complete. Files in `harmony/`.

## What's in the final project folder

```
harmony/
├── concept.md           — confirmed summary + pillars
├── brief.md             — audience, take-away, vision
├── script.md            — final script with timing
├── design.md            — design language with hex codes
├── voice.json           — Rachel + settings
├── remotion/
│   ├── src/
│   │   ├── data/film.ts
│   │   ├── compositions/
│   │   └── ...
│   └── public/
│       ├── audio/{hook.mp3, voiceover.mp3}
│       └── screens/{harmony-1-dashboard.png, ...}
├── out/
│   ├── hook.mp4         — 13 seconds
│   └── final.mp4        — 78 seconds
└── README.md
```

## What this example demonstrates

- The skill asked **three** questions total, and one of them was a confirmation-of-inference rather than an open question
- Variant selection was named in one sentence, no menu presented
- The script was produced in full at the end of Phase 3, with timing math shown
- Design tokens came from Figma extraction; no two-direction proposal was needed
- Voice audition presented four voices, the user picked one, the skill noted the alternates
- Hook render happened before any full render; iteration happened on the hook before committing to the full
- Total elapsed time: roughly 25 minutes from "let's make a concept film" to `final.mp4`

This is the rhythm. Stay in it.
