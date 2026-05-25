# Audio-Visual Sync

The most common failure mode of a concept film isn't bad copy or bad design — it's audio and visuals that don't move together. This file is the operating manual for keeping them locked.

Read this before writing `film.ts` section timings, and again during render review.

---

## 1. Audio-visual sync principles

The audio is the spine. Everything else accommodates it.

- **Measure actual TTS audio duration with `scripts/measure-audio.sh` BEFORE writing `film.ts` section timings.** Word-count estimates lie — voice pacing, phrasing pauses, and model-specific cadence all push the real duration off the estimate by 10–25%.
- **Section durations in `film.ts` must match actual audio length, not estimated word-count timing.** Render the TTS first, measure it, then write the section blocks against the measured beats.
- **If TTS runs longer than estimated, adjust `film.ts` — never speed up or compress the audio.** Time-stretching destroys voice quality and breaks the warm-confident register that the genre depends on. Lengthen the section, hold the visual longer, or trim the script.
- **Update `meta.totalDuration` to equal the sum of section durations every time you adjust.** Remotion derives composition length from this value; a mismatch truncates or pads the render.
- **One audio file per composition.** Hook uses `public/audio/hook.mp3`; Full uses `public/audio/voiceover.mp3`. Don't try to stitch per-section clips at render time — gaps and click artifacts will show up.

## 2. Visual beat alignment

Every VO sentence needs a visual partner. Static screens during spoken content read as dead air.

- **Every VO sentence must have a corresponding visual beat. No lines where the screen is static.** If you find a sentence with nothing happening visually, either add a beat or merge the sentence into an adjacent line.
- **Visual transitions should LEAD voiceover by 200–400ms.** The eye processes faster than the ear. If the visual lands exactly with the word, it feels late. Start the entrance just before the word arrives.
- **"One idea per beat" — each `sceneProps` entry should map to exactly one visual concept per VO sentence.** Stacking two ideas onto one beat weakens both.
- **When VO says "X, Y, Z" in sequence, the visuals must show X, then Y, then Z in that order — not all at once.** A list in copy is a sequence on screen. Stagger entrances; don't fan them in simultaneously.
- **Match visual register to vocal register.** A whispered insight gets a slow, quiet visual; a confident vision close gets a definitive cut and a held frame.

## 3. Cover frame and first three seconds

The first frame is a still before it is motion. It may become the video poster, a preview image in a deck, or the frozen state in a player.

- **Render and inspect `out/cover-frame.png` after the hook render.** `scripts/render-hook.sh` exports frame 0 from the Hook composition for this purpose.
- **Frame 0 must contain the primary visual at full opacity.** Do not fade in from black, white, brand color, or an empty UI unless that blankness is the intentional cover and can still carry meaning.
- **The still must read without VO.** If the user cannot understand the visual register, subject, or promise until the narrator speaks, rewrite the cold-open visual.
- **Check it at 25% size.** Product UI and long type often look fine full-screen and collapse as a thumbnail.
- **The first three seconds should reward the still.** Motion can reveal depth, but it should not replace the frame-0 idea with a completely different hook.

## 4. Transition timing

Transitions are punctuation. They belong between sentences, not inside them.

- **Scene-to-scene transitions: 400–700ms crossfade or wipe, timed to land BETWEEN VO sentences, not during.** A transition mid-sentence cuts the listener's attention in half.
- **Within-scene element entrances: 200–400ms, staggered by 100–150ms when multiple elements appear.** Simultaneous entrances feel mechanical; a 100ms stagger reads as intentional choreography.
- **Hold times: minimum 1.5s on any text the viewer needs to read; minimum 2s on product screens.** Reading rate is roughly 4 words/second for short overlays; product screens need dwell time to be legible.
- **Cold open: do not transition in the first 800ms.** Let the opening frame establish before anything moves. A motion in frame 1 looks like the render is glitching.
- **Vision close: hold the final frame for at least 3s after VO ends.** The film needs to land in silence.

## 5. Common sync failures and fixes

If you can name the failure, you can fix it at the data layer instead of re-rendering blindly.

- **"First frame is blank"** — the cold-open scene has a delayed entrance on its primary element. Ensure cold-open scene has immediate visual content from frame 1. Check `sceneProps` for any `delay` or `entranceFrom` value > 0 on the first element.
- **"VO and visuals feel disconnected"** — usually caused by even timing across sections (every section the same length). Vary the pacing — Insight beats should be shorter and held longer; ProductWalk beats should be longer per-screen than Problem beats.
- **"Product screens flash too fast"** — increase `dwell` time in `ProductWalk` `sceneProps`. Minimum 2s per screen; 2.5–3s is more typical for screens with detail the viewer is meant to absorb.
- **"Ending feels abrupt"** — VO ends and the render cuts within a frame or two. Hold the final frame (logo + URL) for at least 3 seconds of silence after VO ends. Lengthen `vision-close` `duration` by 2–3s past the audio end.
- **"Transitions feel jerky"** — easing curve mismatch. Entrance and exit easings should be different families (slow-in / snap-out, e.g., `cubic-bezier(0.16, 1, 0.3, 1)` in, `cubic-bezier(0.7, 0, 0.84, 0)` out). Linear easings look like After Effects in 2008.
- **"VO and on-screen text fight each other"** — kinetic typography overlays read while VO speaks adjacent words. Either let the typography carry the line (VO silent) or let the VO carry the line (typography minimal). Don't try to do both at once.
- **"Voice arrives before any visuals"** — VO starts at frame 0 but the cold-open visual fades in over 1s. Pre-position the visual at full opacity at frame 0; let motion (push-in, light shift) carry the entrance instead of opacity.

---

When in doubt: render the hook, watch it once at 1x speed without touching the timeline, and ask "did anything feel late, early, or dead?" If the answer is yes, fix it in `film.ts` and re-render. The sync problems are always in the data, not in the template.
