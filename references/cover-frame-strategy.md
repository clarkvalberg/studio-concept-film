# Cover Frame Strategy

Read this in Phase 4 when defining design direction, and again in Phase 6 before presenting the hook.

The cover frame is the video's silent first impression. In many surfaces it becomes the poster image, preview thumbnail, or frozen embed state. It is not decoration and it must not be accidental.

## What the cover frame must do

A strong cover frame reads in one second, without voiceover, motion, or surrounding context. It answers four questions at small size:

1. What kind of thing is this?
2. Whose world are we entering?
3. What is the tone of the film?
4. Why should I press play?

The cover frame should be faithful to the film that follows. Do not make clickbait. The still should create curiosity, then the first three seconds should reward it.

## Relationship to the design thumbnail

The Phase 4 design thumbnail proves the aesthetic. The cover frame chooses the actual frame-0 image of the video.

They can be the same if the film opens on a title-led frame. They should differ when the film opens on a human moment, product state, or concrete problem object. In those cases, the design thumbnail can show the visual system, while the cover frame must show the opening image that will be frozen in embeds and previews.

## Cover archetypes

Pick one archetype before hook render.

**Title-card cover**
- Best when the concept is early, abstract, or lacks strong product imagery.
- Frame 0 carries the project name, one tight phrase, and a confident visual system.
- Avoid long taglines. Six words is already a lot.

**Product-first cover**
- Best when the product is visually striking and self-explanatory.
- Frame 0 shows the strongest real product state, not a loading screen, empty dashboard, or transitional state.
- UI must still read at 25% size. If it becomes texture, simplify the crop.

**Human-moment cover**
- Best for customer-led films where the viewer should enter through empathy.
- Frame 0 shows a person, place, or problem object mid-situation.
- Avoid posed stock feeling. The still should feel observed, not staged.

**Thesis cover**
- Best for insight-led films where the argument is the hook.
- Frame 0 carries a short sentence, fragment, or question with enough contrast to read as a still.
- Use this only when the line is strong enough to earn the frame.

## Required `design.md` section

Add this section after Imagery:

```markdown
## Cover Frame Strategy
- Archetype: [title-card / product-first / human-moment / thesis]
- Frame 0 image: [what is visible on the first frame, not what appears after animation]
- On-screen text: [exact text, or "none"]
- Read-at-small-size check: [why it still reads at 25% size]
- Why it earns play: [one sentence]
- By second 3: [what changes or is revealed after the frozen cover]
```

## Avoid

- Blank or near-blank fade-ins
- Logo-only first frames unless the brand already carries meaning for this audience
- Generic dashboards, empty states, or tiny UI that collapses at thumbnail size
- Long sentence overlays that need full resolution to read
- A first frame that depends on voiceover or motion to make sense
- A first frame whose tone misrepresents the film that follows
- Random frame-0 states created by delayed opacity, sequence offsets, or loading placeholders

## Phase 6 review

After `scripts/render-hook.sh <project>`, inspect both outputs:

- `out/cover-frame.png` for silent poster-frame quality
- `out/hook.mp4` for the first three seconds of motion and voice

The cover frame passes only if:

- Frame 0 is not blank, glitched, or transitional
- The still works at 25% size
- The still does not require VO to be understood
- The still matches the film's actual tone and promise
- The first three seconds reward the still rather than replacing it with a different idea

If it fails, adjust the cold-open section in `film.json` or the design tokens, then re-render the hook. Do not present the hook with a weak cover frame and hope the video saves it.
