# FAQ

Practical answers about the skill and its workflow.

---

### Why concept films and not video generally?

Because the skill is designed for one specific format: short, voiceover-led concept films grounded in a product idea or prototype. Keeping the scope narrow makes the workflow easier to judge and easier to iterate.

### Why 60–90 seconds?

It's the length at which a concept can be made legible without the film overstaying its welcome. Below 45 seconds, you can't earn the vision close. Above 120 seconds, you start losing the LP at slide 8 of their own deck. 60–90 is the band where the form lives.

The skill supports up to 120s, but every additional 30 seconds adds compounding risk that the film starts feeling like an explainer. Default to 75s if you can't decide.

### Why does it pick the variant silently?

Because asking the user to pick from three structural variants in Phase 3 is usually not the best use of attention. The skill picks based on signals in the brief, then names the choice in a single sentence so you can redirect if the read was wrong. The saved time goes to decisions that are easier to judge: script, design, voice, and hook.

### Why only eight voices?

Because auditioning dozens of voices usually slows the workflow. With eight defaults, each voice has a clear role, and Claude can match four to your specific brief based on audience and tone.

### Why a hook render before the full render?

The hook is the iteration unit. Most edits happen in the first 15 seconds — the cold open, the voice, the pacing, the design tokens. Re-rendering the full film for each edit wastes 7+ minutes per revision. The hook lets you tune the most expensive failure modes cheaply. Once the hook lands, the rest of the film typically lands too — the structure is the same, the design is the same, the voice is the same.

This is a core UX decision in the skill.

### Why a design thumbnail before voice audition?

Because it is hard to approve an aesthetic from hex values and font names alone. The skill renders `out/design-thumbnail.png` in Phase 4: a title-frame style artifact that makes the type, palette, spacing, screen treatment, and tone visible before voice and video render time enter the loop. It is cheap to revise and gives the user something concrete to react to.

### Why a separate cover frame?

Because the first frame often becomes the video's poster image in an embed, a deck, or a local preview. The design thumbnail proves the aesthetic; `out/cover-frame.png` proves the actual frame 0 of the hook. It has to read silently, at small size, before voice or motion can help.

### What if my website is not the look I want?

Say so at the visual source checkpoint in Phase 4. The skill asks before defining design so you can add a screenshot, deck, Figma, brand guide, reference site, moodboard, or just a desired aesthetic. In that case, the website stays useful for product truth, but the newer visual reference becomes design truth.

### Why those banned words?

Because they are heavily overused in pitch decks and product pages. Words like "revolutionary," "game-changing," and "leverage" often make a script feel less specific. The list is a guardrail against generic language.

The full list and the reasoning are in [`references/script-rules.md`](../references/script-rules.md).

### Can I add my own banned words?

Yes. The list is in [`references/script-rules.md`](../references/script-rules.md). Add or remove freely for your house style. The skill respects the list as authoritative.

### How much does a film cost to render?

Compute is free if you render locally — your machine, Node, Remotion. The main cost is ElevenLabs credits for voiceover generation. A 90-second voiceover at standard quality is roughly 1,500 characters; pricing varies by plan but typically costs cents. Hook audition (four 15-second samples) costs around 4× that.

### Can I use a voice not in the shortlist?

Yes. The skill will use any ElevenLabs voice ID you provide. The shortlist is a *default*, not a constraint. If you find a voice that fits your house style, ask Claude to add it to your default shortlist for future runs.

### Does the skill generate the prototype?

No. The skill takes a prototype as input — Figma link, deployed URL, screenshots, or a reference. Generating prototypes is a different job done better by other tools (Figma, v0, Lovable, real code). If you don't have a prototype yet, the skill uses schematic stand-ins and flags it in the brief; you can swap real screens in later and re-render.

### Why Remotion?

Because the rendering layer needs to be programmatic, version-controlled, and editable by humans. After-Effects-style timeline editors don't satisfy any of those. Remotion lets the film be a TypeScript project — the script lives in a data file, the design lives in tokens, the scenes are components. You can hand the resulting project to a designer or engineer and they'll know what to do.

It also renders entirely locally, so there's no SaaS dependency on the rendering side. Your videos are your videos.

### Why not Premiere / Final Cut / DaVinci?

Those are excellent tools for film editing, but a concept film generated from a brief is *authored*, not *edited*. The film exists because a script + design + voice + screens combined deterministically. That's a build problem, not an editing problem. Remotion is the right shape for builds.

If you want to refine the final render further in a video editor, export from Remotion and import into your tool of choice.

### How is this different from a Loom recording or a generated AI video?

A Loom is a recorded walkthrough. A generated AI video is usually a synthetic montage. Both have their place. A concept film is neither — it is an authored film with a script, a structure, a chosen voice, real or schematic product screens, and a designed visual language.

### Can I run the skill without ElevenLabs?

The skill expects voiceover. You could render without audio by skipping Phase 5 and using silent scenes, but you'd be producing a different artifact — closer to a motion graphic than a concept film. If voiceover isn't available, consider whether the concept-film genre is the right fit at all.

### Can I run this skill without Claude?

The Remotion template, the scripts, and the references are all standalone. You can use the template directly — write `film.ts` and `BrandTokens.ts` by hand, generate audio with the included `scripts/audition.sh` and `scripts/generate-voiceover.sh`, and render. The skill is the orchestration layer; the underlying machine works without it.

The orchestration is still the main value: structure selection, script rules, design proposal, voice matching, legibility gate, and hook review. Without Claude, the template remains useful, but the process becomes more manual.

### Is this repository open to contributions?

No. The repository is public for reference and installation, but external issues, pull requests, discussions, projects, and wiki are disabled.

### Who built this?

Built inside [Transformative Studio](https://transformative.studio), which builds AI-native vertical ventures. The skill exists to make a specific concept-film workflow repeatable.

### Where can I see films made with this?

The Signatures.law example in [`docs/EXAMPLES.md`](EXAMPLES.md) walks through the full process if you want to see the shape of a run before trying it yourself. For current studio context, use the [Transformative Studio](https://transformative.studio) website as the source of truth.
