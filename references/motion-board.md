# Motion Board

Use this in Phase 3B before design, and again in Phase 6 before showing the hook. The goal is to prevent the film from becoming voiceover over beautiful slides.

## Doctrine

A concept film is not a narrated deck. It is a visible transformation.

Taste can come from a deck, brand system, website, or screenshot. Format cannot. A reference like "match North" means borrow the restraint, typography, palette, and confidence. It does not mean hold static exhibit images under VO.

Every beat must move the viewer from one state of understanding to another, and the product should cause or clarify that movement.

## Required board

Create `motion-board.md` after the script is approved.

```markdown
| Time | VO | Visual action | Before state | After state | Product proof | Motion mode | Scene implication | Static risk |
|---|---|---|---|---|---|---|---|---|
| 0:00-0:06 | ... | ... | ... | ... | ... | object-flow | ... | low |
```

Use 5-8 second beats. Shorter is fine for transitions; longer needs a reason.

## The explainer test

Each beat must answer:

1. What changes on screen?
2. Why did it change?
3. What did the product, user, system, or object do?
4. What does the viewer understand now that they did not understand five seconds ago?

If the answer is only "a new line of text appears," the beat is not an explainer beat.

## Motion modes

Use one primary mode per beat.

- `human-action`: a person acts, hesitates, decides, reviews, approves, or reacts.
- `object-flow`: documents, records, messages, files, cards, or tasks move through a process.
- `product-state-change`: the UI changes because the product acts: labels appear, fields populate, routes split, outputs generate.
- `camera-move`: camera behavior creates understanding: push in to reveal, lateral track across a system, rack focus between before/after.
- `kinetic-type`: typography is the action. Use sparingly for the cold open, the insight turn, or a final thesis.
- `lockup-hold`: logo, tagline, or final brand hold. Use only at the end unless there is a deliberate title-card opening.

Do not use `kinetic-type` or `lockup-hold` for more than one consecutive beat.

## Product causality patterns

Pick the pattern that matches the concept.

**Input -> interpretation -> output**
Use for AI/workflow products. Show messy input entering, the product making sense of it, and a cleaner output appearing.

**Problem object -> system judgment -> human decision**
Use for professional tools. Show the object of work, the product's analysis, then the user making a better decision.

**Current workflow -> interruption -> new path**
Use for customer-led films. Show how the old workflow breaks, then how the product changes the next move.

**Before map -> reclassified map -> action lane**
Use for platforms and ontologies. Show categories changing, not just screens changing.

## Red flags

- The same composition repeats for more than two beats.
- The VO names the product action, but the screen only shows a finished state.
- A deck, PDF, or screenshot becomes the full-frame scene for most of the film.
- The product walk is a list of capabilities instead of a chain of cause and effect.
- The first 10 seconds still make sense only with audio on.
- Every transition is fade, dissolve, or gentle slide.
- The scene data uses `motion: 'static'` without a written reason.

## Pass criteria

Before Phase 4:

- Every beat has a before state and after state.
- Every beat has visual action.
- Product Walk contains at least three linked product actions.
- At least two distinct motion modes appear in the first 20 seconds.
- No more than one consecutive beat is type-led or static.

Before presenting the hook:

- Watch or inspect the hook muted.
- Confirm a meaningful state change happens before the VO has to explain it.
- Confirm frame 0 is not a blank setup or accidental hold.
- Confirm the hook feels like the beginning of a film, not the first slide of a deck.

## Example

For a legal signing-packet product:

```markdown
| Time | VO | Visual action | Before state | After state | Product proof | Motion mode | Scene implication | Static risk |
|---|---|---|---|---|---|---|---|---|
| 0:00-0:06 | The deal is closed. The signing packet is not. | A clean closing binder opens; loose signature pages spill out of order. | Deal appears finished. | Hidden packet mess becomes visible. | Source docs are mixed and unresolved. | object-flow | Macro document scene, slow push then spill. | low |
| 0:06-0:13 | Every signature page has a legal return path. | Pages move into four routing lanes. | Pages look interchangeable. | Legal paths become visible. | Recording, non-recording, wet ink, DocuSign labels. | product-state-change | Routing-lane UI with labels applied. | low |
| 0:13-0:20 | The product classifies the path and keeps the receipt. | Labels lock, outputs split, receipt trail appears behind each decision. | Classification is implied. | Judgment and proof are visible. | Output packets plus audit trail. | product-state-change | Product UI close-up with callouts. | low |
```
