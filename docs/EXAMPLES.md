# Examples

## Signatures.law Video

[Watch the playable Signatures.law video page](https://clarkvalberg.github.io/studio-video-creator/)

<video src="media/signatures-law-final-2026-05-25.mp4" controls width="100%">
  <a href="media/signatures-law-final-2026-05-25.mp4">Watch the Signatures.law example video</a>
</video>

[Open the Signatures.law example video](media/signatures-law-final-2026-05-25.mp4)

This is the real Signatures.law render currently used as the reference example. The walkthrough below shows the workflow shape behind a customer-led concept film: what each phase looks like in practice, what gets decided, and what artifacts the skill should produce.

These examples are illustrative. They show the shape of a run without making public claims about Transformative Studio, launched ventures, customer research, or real product availability unless source material is linked.

| Example | Variant | Concept type | Length |
|---|---|---|---|
| [**Signatures.law**](#signatureslaw-customer-led) | Customer-led | Legal closing-packet workflow | 1:21 reference video |

Additional variants should be added only when there is a real film artifact to show first. The structural variants are documented in [`../references/frameworks.md`](../references/frameworks.md).

---

# Signatures.law (Customer-led)

A complete worked example of the skill applied to a real studio concept: Signatures.law, a closing-packet workflow for real estate legal teams. Read this when running the skill for the first time, or anytime the abstractions in `frameworks.md` need grounding in a current, product-native run.

The long-form reference version lives in [`../references/example-signatures-law.md`](../references/example-signatures-law.md).

## What the user provided

The user provided:

1. The product URL: `https://signatures.law`
2. Screenshots of the parent-company visual system to match
3. Directional feedback during the run: "match the parent company," "this feels like a voiceover with a slideshow," "go full," and specific voiceover notes on the closing line

User's prompt: *"the parent company, match it"*

## Phase 1 — Intake & legibility gate

The skill read the product surface and extracted the wedge:

- Signatures.law takes an unsorted stack of real estate closing PDFs and finds the signature pages.
- The product classifies each signature page by return path: recording pages for wet-ink filing and non-recording pages for DocuSign.
- The real value is not just extraction; it is reviewability, correction history, and a defensible chain of custody.
- The visual direction should inherit from the parent company: editorial, sparse, ivory field, dark ink, red signal marks, and deck-like discipline.

**Two-sentence summary the skill produced:**

> Signatures.law is a web app for real estate closing teams that turns an unsorted stack of closing PDFs into reviewed signature-page packets: recording pages for wet-ink filing and non-recording pages for DocuSign.
>
> Its wedge is that the painful work is not just extraction, but legal return-path classification plus auditability: every AI classification, correction, output PDF, checklist, and document fingerprint becomes part of a defensible chain-of-custody record.

**Minimum prototype surface named:**

> To do this concept justice, the video should show the binder entry point, document upload/dropzone, classification review screen with recording/non-recording badges, the generate-two-PDFs moment, and the resulting audit artifacts.

The user confirmed the direction.

`Concept locked. -> Phase 2.`

## Phase 2 — Three sharp questions

The source material answered most of the intake questions, so the skill made explicit inferences instead of asking for a menu of preferences:

- **Audience:** real estate lawyers, closing associates, and paralegals under time pressure at the end of a deal
- **Single insight:** the hard part is knowing which signature pages require wet-ink recording, which can go through DocuSign, and proving that every judgment was made and corrected cleanly
- **Vision statement:** every closing produces its own signing packets, checklist, and audit trail the moment the deal team drops in the documents

The user kept the strategic read and pushed on the presentation: it needed to feel like the parent company, not a generic product ad.

`Brief assembled. -> Phase 3.`

## Phase 3 — Variant selection and script

**The skill's variant decision:**

> This wants to be **customer-led** — opening on the late-closing moment. The viewer should feel the end-of-deal pressure before the product starts sorting anything.

The skill then produced the script:

```markdown
# Signatures.law Concept Film Script

## Cold Open (0:00–0:08)

**[On-screen:** Close-up of a desk at dusk. A thick stack of closing PDFs lands beside a laptop. The cursor blinks on an empty binder screen. Slow push in.**]**

**VO:** It's 6:41 PM. The deal is closed. The signing packet is not.

## Problem (0:05.2–0:27.0)

**[On-screen:** Fast, restrained cuts: deed signature page, mortgage signature page, operating agreement, FedEx label, DocuSign tab, email thread. The stack separates into messy, half-formed piles.**]**

**VO:** On a real estate closing, the last mile is a stack of PDFs. Deeds, mortgages, affidavits, operating agreements. Some pages need wet ink and a trip to the recorder. Some can go through DocuSign. Every mistake creates another call, another label, another quiet risk in the file.

## Insight (0:27.0–0:36.0)

**[On-screen:** The paper piles freeze. Recording and non-recording labels appear, then resolve into a simple two-column structure. The clutter drops away.**]**

**VO:** The hard part is not making a packet. It is knowing what each signature page is, where it goes, and leaving a record of that judgment.

## Product Walk (0:36.0–1:08.4)

**[On-screen:** New binder. Dropzone. Upload progress. Document cards appear with page counts, party names, signatory names, and recording/non-recording badges. A badge toggles once. A generate button produces two PDFs and three audit files.**]**

**VO:** Signatures.law starts with one binder for the closing. Drop in every PDF, unsorted. It reads each page, finds the signature pages, and classifies the return path: recording or non-recording. The team reviews the list, fixes anything wrong, and generates two files. One for wet-ink filing. One for DocuSign. Alongside them: a checklist, a corrections ledger, and a manifest of every source document.

## Vision Close (1:08.4–1:21.1)

**[On-screen:** The two PDFs sit beside signatory-tracker.csv, corrections-ledger.json, and manifest.json. The screen settles into the Signatures.law wordmark on paper-colored background.**]**

**VO:** The closing packet becomes more than ready to send. It becomes traceable. Signatures dot law ... Closing packets — assembled.
```

## Phase 3B — Motion board and explainer grammar

The first render looked too much like a voiceover with slides. The user called this out directly:

> "This feels like a voiceover with a slideshow, not at all the kind of video explainer we're going for."

The skill responded by applying a motion-and-communication pass before continuing.

**Frameworks applied:**

- **Recognition before persuasion:** open with the real closing condition.
- **State change over feature list:** every product beat needs a before state, an action, and an after state.
- **One cognitive object per beat:** the viewer should track one new idea at a time.
- **Semantic motion:** pages move because the system is sorting, reviewing, routing, or proving lineage.
- **Attention staging:** keep a left-to-right mental model: source stack -> classifier/review -> wet-ink and DocuSign outputs -> audit trail.

The product walk became a causal chain:

```text
unsorted PDFs -> signature pages -> return-path classifications -> review correction -> two output packets -> audit trail
```

## Phase 4 — Design direction and thumbnail

The user wanted the film to match the parent company. The skill extracted the usable visual language and wrote it into `design.md`.

**Design tokens:**

- Display: Kepler-style italic serif, oversized and high-contrast
- Labels / metadata: small uppercase sans, restrained
- Background: ivory deck field
- Ink: deep navy/black
- Accent: red signal marks for underline, bullet, emphasis, and exceptions
- Support: warm gray metadata and thin rules
- Motion: private-placement editorial; slow, confident, slide-like, but always tied to product causality

`Design locked. -> Phase 5.`

## Phase 5 — Voice audition

The skill auditioned voices against the thesis-film register. Four voices were generated and played in a local audition page:

1. Brian
2. Daniel
3. Lily
4. Rachel

The user chose **Brian**.

`voice.json` saved:

```json
{
  "voice_id": "nPczCjzI2devNBz1zQrb",
  "voice_name": "Brian",
  "model": "eleven_multilingual_v2",
  "audition_notes": "Chosen for the thesis-film register: grounded, confident, and category-aware without sounding like a product ad.",
  "settings": {
    "stability": 0.56,
    "similarity_boost": 0.7,
    "style": 0.34,
    "use_speaker_boost": true
  }
}
```

## Phase 6 — Hook render

The skill scaffolded the HyperFrames project, wrote the film data, generated section audio, and rendered the hook.

The first hook proved the brand direction but not the explainer grammar. The user pushed on it, and the skill built a custom scene system around product-native state changes:

- `document-motion` for the closing stack and first problem
- `route-sort` for wet-ink vs DocuSign routing
- `trace` for the judgment record
- `intake` for the binder/dropzone/classification flow
- `review` for correction and human-in-the-loop review
- `outputs` for the generated packets and artifacts
- `close` for the final traceable packet lockup

## Phase 7 — Iteration and final render

User feedback narrowed to two precise issues: the final line and an awkward opening pause.

**Final line.** The user wanted:

> "Signatures dot law ... Closing packets — assembled."

Because TTS is non-deterministic, the skill generated five takes of only the final line, built a local audition page, and the user chose **take 04**. The chosen take was copied into the HyperFrames project as the final audio source and given a post-roll hold so the film did not end abruptly.

**Opening pause.** The user noticed an awkward early pause. The skill measured the audio envelope instead of guessing:

- Original dead air after the cold open: too long
- First timing pass: about `1.10s`
- Final timing pass: about `0.70s`, a deliberate breath rather than a hole

Final render:

- Duration: `81.13s`
- Resolution: `1920x1080`
- Frame rate: `30fps`
- Frames: `2433`

## What's in the final project folder

```text
signatures-law/
├── brief.md
├── script.md
├── design.md
├── motion-strategy.md
├── voice.json
├── voice-auditions/
│   ├── index.html
│   └── final-line-takes/
├── hyperframes/
│   ├── data/
│   │   ├── film.json
│   │   └── tokens.json
│   ├── compositions/
│   │   ├── hook.html
│   │   └── full.html
│   └── public/audio/segments/
└── out/
    ├── hook.mp4
    ├── front-16s-pause-fix-tight-check.mp4
    └── final.mp4
```

## What this example demonstrates

- The concept summary identified the real wedge: classification plus auditability, not generic PDF assembly.
- The visual language came from a parent-company system, but the film still needed product-native motion.
- User critique was treated as signal: "slideshow" became a motion-strategy correction.
- The product walk became causal: input -> read -> classify -> review -> generate -> prove.
- Voice was selected through auditions, then refined with targeted final-line takes.
- Timing QA used audio measurement, not intuition alone.
- The full render happened only after the hook, voice, final line, and timing all landed.
