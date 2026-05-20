# Examples

Two complete, end-to-end walkthroughs of the skill in action. Together they show the customer-led and insight-led variants, what each phase looks like in practice, and how the same gates produce different *shapes* of film depending on where the concept's energy lives.

| Example | Variant | Concept type | Length |
|---|---|---|---|
| [**Harmony**](#harmony-customer-led) | Customer-led | Vertical AI for affordable housing operations | ~78s |
| [**Reflex**](#reflex-insight-led) | Insight-led | Developer debugging tool | ~78s |

The demo-led variant will be added when a film is made through the skill that calls for it. The structure is documented in [`../references/frameworks.md`](../references/frameworks.md#variant-c--demo-led) in the meantime.

---

# Harmony (Customer-led)

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

---

# Reflex (Insight-led)

A second worked example, this time showing the insight-led variant. The concept is fictional but the structure is real — the same skill, the same gates, a different shape because the concept lives in a different place.

**Reflex** is a debugging environment for frontend engineers. It captures the full state of a bug — DOM, network, console, user actions — as a single shareable link. The team's argument: most bugs are reproduction problems, not logic problems. *"Works on my machine"* is the failure mode. Reflex makes that obsolete.

This concept has a striking insight at its center (*reproduction is the bug*). The variant picks itself.

## Phase 1 — Intake and legibility gate

**The user provides:** a six-page concept memo, a deployed marketing site (`reflex.dev` — fictional), and a 90-second Loom of the product working.

**Claude reads everything**, including the Loom (transcribing the on-screen narration and extracting screenshots at scene boundaries).

**Two-sentence summary:**

> Reflex is a debugging environment for frontend engineers that captures the full state of a bug — DOM, network, console, user actions — into a single shareable link.
>
> Most software bugs are reproduction problems, not logic problems; Reflex makes "works on my machine" obsolete by giving the team a time-travel debugger that another engineer can replay exactly.

**The user confirms** without changes.

**Minimum prototype surface:** the capture moment (a developer hitting a button to start recording), the captured-bug detail view, the timeline scrubber, the shareable link. The Loom covers all four. No gaps.

`Concept locked → Phase 2.`

## Phase 2 — Three sharp questions

The brief and the Loom are dense enough that Claude infers audience and skips that question. It asks two:

> **1. The single insight.** I'm reading it as: *most bugs are reproduction problems, not logic problems.* Confirm or correct.
>
> **2. The vision statement.** I see two candidates from the memo: *"Software for engineers who solve problems"* and *"The end of works-on-my-machine."* Either works. Pick one or propose a third.

**The user responds:**

> 1. Right read. Sharpen it: *reproduction is the bug — once a bug is reproducible, it's already half-fixed.*
>
> 2. Go with the first one. The second is too cheeky.

`Brief assembled → Phase 3: structure and script.`

## Phase 3 — Variant and script

Claude names the choice:

> This wants to be **insight-led**. The concept's energy is the argument itself — that reproduction is the bug. We open on that argument, prove it through the product, land on a vision that earns the aspiration. The human moment is real but secondary; the idea is what pulls the viewer in.

Claude reads `references/frameworks.md` and `references/script-rules.md`, then drafts:

```markdown
## Cold Open (0:00–0:06)

**[On-screen:** A cursor blinks in a Slack thread. The thread reads:
"works on my machine — anyone else seeing this?" — five unread responses below.**]**

**VO:** Software engineering has a recurring nightmare.

## Problem (0:06–0:20)

**[On-screen:** Cut to a series of bug-report screenshots — a Linear ticket
with "cannot reproduce" closing the loop. A senior engineer with three browser
tabs open and a frown.**]**

**VO:** Someone reports a bug. You can't reproduce it. They send a screenshot.
You still can't reproduce it. They send a video. You still can't. So the bug
gets closed. And lives on.

## Insight (0:20–0:32)

**[On-screen:** Slow transition to dark space. Two lines of type appear,
one after the other.**]**

**VO:** Most bugs aren't logic problems.
       They're reproduction problems.

       Once a bug is reproducible, it's already half-fixed.

## Product Walk (0:32–1:05)

**[On-screen:** Reflex interface, real screens. Four beats, each showing
a different moment of the product working.**]**

**VO:** Reflex captures the full state of a bug. (0:35)
       DOM. Network. Console. The exact user actions. (0:42)
       One shareable link. Another engineer opens it, scrubs the timeline,
       sees what you saw. (0:54)
       The bug is reproducible. Now it's solvable. (1:02)

## Vision Close (1:05–1:18)

**[On-screen:** Wide shot of an engineer closing the laptop, satisfied.
Crossfade to the Reflex logo, held.**]**

**VO:** Software for engineers who solve problems.
       Reflex.
```

Word count: 165. Within budget for a 78-second target.

Claude saves to `script.md`.

`Script drafted → Phase 4: design direction.`

## Phase 4 — Design direction

The deployed `reflex.dev` site has an established identity — sober monochrome with one accent. Claude extracts and proposes no alternatives:

```markdown
## Typography
- Display: Söhne Breit, weight 700 (used on the insight section and vision close)
- Body: Söhne, weights 400 and 500
- Mono: JetBrains Mono, weight 400 (used in code overlays and captions)

## Color
- Background: #0E0E10 (near-black with a hint of cool)
- Ink: #EDEDED
- Accent primary: #00D26A (Reflex green — from the captured-bug indicator)
- Surface: #18181B
- Mute: #6B6B70

## Motion
- Standard transition: 180ms cubic-bezier(0.16, 1, 0.3, 1) — slightly snappier than Harmony
- Code overlays type on at 28ms per character
- Scene transitions are hard cuts on the insight section, crossfades elsewhere

## Imagery
- Real product screens at 80% frame width, with a subtle inner border
- Code snippets shown in mono, with the cursor visible — the product is a tool for code-readers
- No photography; this is a product film for engineers, not a brand film
```

`Design locked → Phase 5: voice audition.`

## Phase 5 — Voice audition

Audience is senior engineers. Tone is confident curiosity — *the film is thinking out loud with the viewer.* Claude pulls:

- Adam — gravitas, the "this is real" register
- Antoni — peer-to-peer, more conversational; might fit the engineer audience
- Lily — editorial cadence, slightly cooler
- Sarah — clear and neutral, lets the argument carry

Four 12-second audition samples generated via ElevenLabs MCP.

**The user picks Antoni.** *"He sounds like an engineer would. Not like a brand."*

`voice.json` saved:

```json
{
  "voice_id": "ErXwobaYiN019PkySvjV",
  "voice_name": "Antoni",
  "model": "eleven_v3",
  "audition_notes": "Picked for engineer audience — peer-to-peer register beats institutional gravitas here.",
  "settings": { "stability": 0.5, "similarity_boost": 0.75, "style": 0.0, "use_speaker_boost": true }
}
```

`Voice selected → Phase 6: hook render.`

## Phase 6 — Hook render

Same flow as Harmony: scaffold, write `film.ts` and `BrandTokens.ts`, generate the hook audio, render the Hook composition. ~3 minutes.

The hook (Cold Open + Problem, ~20 seconds) lands well. The Slack-thread cold open lands particularly well — the user notes the moment feels recognizable to anyone who's shipped software.

`Hook delivered → Phase 7: iterate or render full.`

## Phase 7 — Iteration and full render

**Round 1 feedback:** *"The 'and lives on' line is too soft — pause for a beat after it. And the transition to the insight section should be harder. Right now it crossfades; I want a cut."*

Claude:
1. Adds 0.4s held silence after *"and lives on"* in `film.ts` (extends Problem section)
2. Sets `transition: 'cut'` between Problem and Insight in scene props
3. Re-renders the hook

Second hook delivered in ~3 minutes. Lands.

**Round 2:** *"Render the full thing."*

Claude generates the full voiceover from the complete script, runs `scripts/render-full.sh`, communicates ~8 minutes. Presents `out/final.mp4`.

## What this example demonstrates (vs. Harmony)

| | Harmony (customer-led) | Reflex (insight-led) |
|---|---|---|
| Opening image | A real person at work | A piece of text from a real interaction (Slack) |
| Problem section | Stays with the person | Pulls back to a pattern across many people |
| Insight delivery | Narration over scene change | Hard typographic emphasis, no imagery |
| Product walk | Captioned beats, four screens | Captioned beats, four screens (same shape) |
| Vision close | Aerial shot of housing units | Engineer satisfaction moment, then mark |
| Voice register | Warm-confident (Rachel) | Peer-to-peer (Antoni) |
| Music build | Slow, lifts on insight | Sparser, more rhythmic, lands on the cut |

The variants are not just different content — they're different *shapes*. The skill's job is to pick the right shape based on where the concept's energy lives, then execute that shape with discipline.

Same gates. Same render economics. Different film.

