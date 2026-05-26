# Design Language

Used in Phase 4. The film has a visual language. You decide it, then show the user. Two paths: extract from an existing brand, or propose two directions when no brand exists.

The output of this phase is a `design.md` file with concrete tokens that flow directly into the HyperFrames template's `tokens.json`, a cover-frame strategy for the video's actual first frame, plus a rendered `out/design-thumbnail.png` style frame. Tokens are the contract; the thumbnail is the proof that the contract feels right.

## What "design language" means for a concept film

A concept film has four design layers. All four must be decided before render.

1. **Typography** — display face (titles, kinetic type) and body face (subtitles, UI captions). Often the same family in different weights; sometimes two complementary families.
2. **Color** — a four-token palette: background, ink (foreground), accent (the one color that punctuates), support (a muted partner to the accent).
3. **Motion** — the pace and easing of every transition in the film. This is the most underweighted layer and the one most viewers feel without naming.
4. **Imagery** — the relationship between product screens, photographic content, kinetic typography, and abstract motion.

A film whose four layers agree feels like a film. A film whose four layers disagree feels like a deck with music.

There is one additional distribution decision: the **cover frame**. It is the actual frame-0 image that often becomes the poster image or frozen embed preview. Decide it in Phase 4, then verify it in Phase 6 from the rendered hook.

## Visual source checkpoint

Before extracting or proposing a design direction, pause and ask whether the current inputs are the intended visual source of truth. The initial concept artifacts may have no design, weak design, or a design that differs from the desired film.

Use a short, confident prompt:

> Before I define the look, I'm using [current sources] as the visual source of truth. If there's a deck, screenshot, brand guide, Figma, reference site, moodboard, past video, or desired aesthetic that should steer the look, add it now. Otherwise say "use these" and I'll thumbnail the direction.

Then act on the answer:

- **User adds material:** read it before deciding. If it conflicts with earlier inputs, treat the newest design-specific source as the source of truth and say so once.
- **User says use current sources:** proceed with extraction or proposal.
- **User has no design but has taste words:** convert them into two visual axes, then propose or thumbnail one direction.
- **User wants a different outcome than the website:** do not extract the website as the brand. Use it only for product/content truth, and use the newer visual references for design truth.

This checkpoint is not a broad creative brief. It exists to prevent anchoring on the wrong visual source.

## Path 1 — Extract from existing brand

When the source material includes a brand (website, Figma library, deck with established system, deployed product), extract rather than propose.

### Inputs to read

- **Website** — `web_fetch` the homepage and 1–2 sub-pages. Look at hero typography, body face, button styles, the one or two colors used most aggressively, the ratio of photography to illustration to type.
- **Figma** — use the Figma MCP if connected. Pull the design system file. Note typography styles, color variables, spacing scale. Take screenshots of key components.
- **Deck** — the deck's typography and color often match the brand even when the system isn't documented. Sample 3–4 slides for typeface and palette.
- **Deployed product** — the product's UI is the most honest brand artifact. Match it.

### Extraction format

Produce `design.md` with this exact shape:

```markdown
# Design Language

## Typography
- Display: [Family Name], [weights used: e.g., 600/700]
- Body: [Family Name], [weights used: e.g., 400/500]
- Rationale: [one sentence — why these, what they signal]

## Color
- Background: #HEXHEX (named: e.g., "warm off-white")
- Ink: #HEXHEX (named: e.g., "deep graphite")
- Accent: #HEXHEX (named: e.g., "house teal")
- Support: #HEXHEX (named: e.g., "muted clay")
- Rationale: [one sentence — what mood, what associations]

## Motion
- Pace: [slow / deliberate / measured / snappy / kinetic]
- Easing: [specific — e.g., "ease-out cubic for entrances, ease-in-out for transitions, no bouncing or elastic"]
- Hold times: [e.g., "minimum 1.5s on any text the viewer needs to read"]
- Rationale: [one sentence — what this motion language signals]

## Imagery
- Product screens: [how prominent, how filmed — static, push-in, parallax]
- Photography: [if any — what style, what subjects]
- Kinetic typography: [when used — for key phrases, for stats, for transitions]
- Abstract motion: [if any — sparing, what role]
- Rationale: [one sentence]

## Cover Frame Strategy
- Archetype: [title-card / product-first / human-moment / thesis]
- Frame 0 image: [what is visible on the first frame, before animation]
- On-screen text: [exact text, or "none"]
- Read-at-small-size check: [why it still reads at 25% size]
- Why it earns play: [one sentence]
- By second 3: [what changes or is revealed after the frozen cover]
```

### Cues that signal a strong extraction

- The display face has personality (not Inter, not generic)
- The accent color is one specific color, not "blue" or "green"
- Motion notes specify the *feeling*, not just "smooth"
- Imagery direction would let a designer recreate the brand from the doc alone
- The cover frame is a specific first image, not "logo/title here" or "opening animation"

If your extraction reads generic, go back and look harder. Brands have specifics; "modern, clean, friendly" is the absence of a brand.

## The design thumbnail gate

Do not ask the user to approve a visual language from tokens alone. Aesthetic feedback needs a visible artifact.

Before rendering the thumbnail, record the cover-frame strategy in `design.md`. Read `cover-frame-strategy.md` when the opening frame could plausibly go more than one way.

After choosing or extracting the design direction:

1. Initialize the project if needed: `scripts/init-project.sh <project>`.
2. Write `design.md` with the tokens and rationale.
3. Write `tokens.json` with the exact typography, color, motion, and spacing tokens.
4. Write enough `film.json` content for the thumbnail: project name, chosen variant, a representative script line, the cover-frame intent, and the vision-close tagline.
5. Render the thumbnail: `scripts/render-design-thumbnail.sh <project>`.
6. Present `out/design-thumbnail.png` and ask for aesthetic approval before voice audition.

The thumbnail should be a 16:9 title frame, not a wireframe and not a mood-board collage. It should make the user feel the intended film in one glance:

- **Title treatment** — the project name in the chosen display typeface and weight.
- **Representative line** — one sentence or fragment from the script showing body type, rhythm, and tone.
- **Screen treatment** — a miniature product/prototype surface showing border radius, density, shadows, and accent use.
- **Palette** — background, ink, accent, and support visible as actual pixels, not only hex text.
- **Motion implication** — composition and spacing should imply the motion language: spacious and held, dense and snappy, editorial and slow, etc.

The thumbnail is allowed to be a title card even when the final cover frame will be a human moment or product state. If those differ, say so explicitly: "This thumbnail proves the design system; the hook will open on [specific cover frame]."

If the user says "warmer," "too SaaS," "more premium," "less dark," or anything similar, treat that as valid design feedback. Update `design.md` and `tokens.json`, re-render `design-thumbnail.png`, and repeat until approved. Only then proceed to Phase 5.

## Path 2 — Propose two directions

When no brand exists yet (true concept stage), propose two directions. Don't propose three — that's a menu. Two forces a real choice.

### How to construct two directions

The two directions should be **meaningfully different**, not variations on a theme. The user should be able to feel the tradeoff.

Common axes to vary across:

- **Editorial vs. utility** — does this feel like a publication or a tool?
- **Warm vs. cool** — does this lean human and aspirational, or technical and precise?
- **Spacious vs. dense** — does the film breathe, or does it pack information?
- **Serif vs. sans** — what era and tradition does the typography invoke?
- **Single accent vs. layered** — one bold color, or a quieter palette of related tones?

Pick two axes. Move them in opposite directions across the two proposals.

### Direction proposal format

Each direction is a named character with concrete tokens:

```markdown
## Direction A — "Apothecary modern"

Serif display, oatmeal background, ink-on-paper feel, generous space, slow deliberate motion. The film feels like a printed monograph that happens to move.

- Display: Söhne Breit Halbfett OR GT Sectra Display
- Body: Söhne Mono (small caps for callouts) OR Sectra Mono
- Background: #F4EFE6
- Ink: #1A1614
- Accent: #8B4F2B (terracotta)
- Support: #C9B89A (clay)
- Motion: Slow ease-outs (700ms+), generous holds, no bouncing
- Imagery: Product screens treated as artifacts — small, centered, lots of negative space; light film grain

## Direction B — "Editorial utility"

Condensed sans, off-white, single ink accent, snappy edits, clean and confident. The film feels like a magazine spread come to life.

- Display: Söhne Schmal Buch OR Druk Wide
- Body: Söhne Buch
- Background: #FAFAF7
- Ink: #0A0A0A
- Accent: #E63946 (signal red)
- Support: #DDDDD8 (paper grey)
- Motion: Snap-in, 200-300ms cuts, occasional slow holds on numbers
- Imagery: Product screens treated as content — large, full-bleed, treated like editorial photography
```

Then ask the user: *"Direction A, Direction B, or describe a third?"* If they pick, lock it. If they describe, use that as Direction C and reconfirm.

If you already have a strong recommendation, say it and thumbnail that direction first. The point is not to make the user compare menus; the point is to make the aesthetic legible quickly. If they reject it, use their reaction to choose or synthesize the next direction and re-render.

## Typography pairs that work in this genre

When proposing, draw from these — they've all carried concept films well:

**Editorial / aspirational**
- GT Sectra Display + GT America
- Söhne + Söhne Mono
- Tiempos Headline + Tiempos Text
- ABC Diatype + ABC Diatype Mono

**Modern / utility**
- Inter Display + Inter (yes, but with care — see note)
- Geist Sans + Geist Mono
- Mona Sans + Hubot Sans (GitHub system)
- IBM Plex Sans + IBM Plex Mono

**Distinctive / characterful**
- PP Editorial New + PP Neue Montreal
- Tobias + Söhne
- Migra + Söhne

Note on Inter: it's a workhorse but it's also everywhere. In a concept film, Inter alone signals "we used the defaults." If you must use it, pair it with something distinctive (a serif display, a mono with character) to add specificity.

## Color palette construction

Concept films rarely use more than four colors. Four is the upper limit, not the target.

### The four-token model

- **Background** — the dominant surface. 85%+ of pixels by area, usually. Pick this first.
- **Ink** — the type and primary marks. Strong contrast with background, but not pure black on pure white unless the film is going for a stark editorial feel.
- **Accent** — the one color that punctuates. Used on 1–3% of pixels but creates the film's color memory. Pick this with care.
- **Support** — a desaturated partner to the accent. Used for secondary marks, supporting graphics, muted UI states. Often a tint or shade of the accent, or a neutral with related undertones.

### What to avoid

- **Three accents.** If you find yourself wanting three accent colors, you actually want one accent and two supports. Pick a hierarchy.
- **Pure black and pure white.** They flatten on video. Use #0A0A0A and #FAFAF7 or similar. The slight warmth makes everything feel more like film and less like a slide.
- **Bright saturated accent on bright background.** Strains the eye, reads as "tech demo." Either calm the accent or warm the background.

## Motion language

Motion is the most underweighted decision. Get it right and the film feels expensive; get it wrong and no design recovers it.

### Three motion languages that fit this genre

**Slow editorial** — long ease-outs (600–900ms), generous holds (2s+), no bouncing, occasional slow pushes on still images. Feels like a documentary. Best with serif typography and warm palettes.

**Modern utility** — quicker cuts (200–400ms), confident snap-ins, occasional held moments for key text. Feels like a well-paced product demo. Best with sans typography and high-contrast palettes.

**Kinetic / typographic** — type animates in chunks, key phrases scale or fill or replace, transitions carry meaning. Best when the script has memorable phrases that deserve typographic treatment.

Most films pick one as primary and borrow one beat from another (e.g., slow editorial with one kinetic typography moment in the insight section).

### Tokens to specify

In `tokens.json`, motion gets these tokens:

```typescript
export const motion = {
  entrance: 'cubic-bezier(0.16, 1, 0.3, 1)',   // ease-out expo (slow)
  exit: 'cubic-bezier(0.7, 0, 0.84, 0)',       // ease-in expo
  transition: 'cubic-bezier(0.4, 0, 0.2, 1)',   // ease-in-out (between scenes)
  durations: {
    fast: 200,
    medium: 400,
    slow: 700,
    hold: 1500,
  },
};
```

The HyperFrames scenes import these tokens — they don't hard-code timings. Keep that contract.

## Using UI reference sources (when available)

If Mobbin, Refero, or another UI reference source is connected, use it to ground design proposals in real-world references. This is especially useful in Path 2 (no brand) to make abstract directions concrete.

### How to query

For each direction you're proposing, run 1–2 UI-reference queries that capture the *feeling* not the *content*:

- *"editorial onboarding screen serif typography warm background"*
- *"financial dashboard utilitarian dense data table single accent color"*
- *"healthcare app patient view warm intimate imagery"*

Pick 2–3 strong references per direction. In the design.md, link them or note them ("Reference: [product name], onboarding flow").

### When to skip external references

- The brand already exists; references are unnecessary
- The user explicitly knows what they want
- No UI-reference source is connected — don't break flow chasing it; the typography/color/motion tokens alone are sufficient

## When the user pushes back on the proposal

The most common pushback: *"I like B but I want the colors from A."* Take it. Build the hybrid as the final direction. Don't argue. The point of two directions is to surface preferences, not to enforce one of two answers.

If the user describes a third direction entirely, listen carefully and ask one question to resolve any ambiguity. Common: *"More like X reference, less like Y."* That's enough to lock the direction.

## A final principle

The design language must serve the script. If the script is intimate and customer-led, an aggressive editorial palette fights it. If the script is insight-led and confident, a soft apothecary palette undercuts it. Re-read the script before locking design — make sure they agree.
