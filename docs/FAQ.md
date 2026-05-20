# FAQ

Questions people actually ask about this skill. Answers without varnish.

---

### Why concept films and not video generally?

Because narrowness is the only way the output gets good. A generic "make me a video" tool produces generic videos. A skill that does one genre well — and refuses to do the others — produces work that lands. The InVision concept film is a specific, narrow, well-understood form. Codifying it is achievable. Codifying "video" is not.

### Why 60–90 seconds?

It's the length at which a concept can be made legible without the film overstaying its welcome. Below 45 seconds, you can't earn the vision close. Above 120 seconds, you start losing the LP at slide 8 of their own deck. 60–90 is the band where the form lives.

The skill supports up to 120s, but every additional 30 seconds adds compounding risk that the film starts feeling like an explainer. Default to 75s if you can't decide.

### Why does it pick the variant silently?

Because asking the user to pick from three structural variants in Phase 3 is a form question, and forms are the wrong texture for a creative tool. The skill picks based on signals in the brief, then names the choice in a single sentence so you can redirect if the read was wrong. The bandwidth saved on a non-decision goes to the decisions that actually matter.

### Why only eight voices?

Because choice paralysis kills the workflow. ElevenLabs has 50+ voices in its public library. Asking a user to audition 50+ voices for a 90-second film is a failure of curation. With eight, every voice earns its slot — and Claude can match four to your specific brief based on audience and tone. You get the audition you actually need, not the audition the API technically supports.

### Why a hook render before the full render?

The hook is the iteration unit. Most edits happen in the first 15 seconds — the cold open, the voice, the pacing, the design tokens. Re-rendering the full film for each edit wastes 7+ minutes per revision. The hook lets you tune the most expensive failure modes cheaply. Once the hook lands, the rest of the film typically lands too — the structure is the same, the design is the same, the voice is the same.

This is the most important UX decision in the skill.

### Why those banned words?

Because they no longer carry signal. "Revolutionary" once meant something. "Game-changing" once described actual category shifts. "Leverage" once described actual asymmetric advantage. Each of these words has been worn through by relentless overuse in pitch decks and product pages. Using one today is a category signal that the writer hasn't noticed how much language has changed. The viewer notices. The film loses the room before the idea has had a chance to land.

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

A Loom is a recorded performance. A generated AI video is a hallucinated montage. Both have their place. A concept film is neither — it's an authored film with a script, a structure, a chosen voice, real product screens, and a designed visual language. The work product is closer to a director's cut than to a screen recording or a Sora clip.

### Can I run the skill without ElevenLabs?

The skill expects voiceover. You could render without audio by skipping Phase 5 and using silent scenes, but you'd be producing a different artifact — closer to a motion graphic than a concept film. If voiceover isn't available, consider whether the concept-film genre is the right fit at all.

### Can I run this skill without Claude?

The Remotion template, the scripts, and the references are all standalone. You can use the template directly — write `film.ts` and `BrandTokens.ts` by hand, generate audio with the included `scripts/audition.sh` and `scripts/generate-voiceover.sh`, and render. The skill is the orchestration layer; the underlying machine works without it.

That said, the skill is most of the value. The frameworks, the script rules, the variant taxonomy, the design proposals, the voice matching, the legibility gate — that's the IP. Removing Claude from the loop turns the toolkit back into a manual craft project.

### Is this skill open to contributions?

Yes, with constraints. See [CONTRIBUTING.md](../CONTRIBUTING.md). Contributions that sharpen the existing opinions are welcome. Contributions that turn it into a more general video tool are not. The narrowness is the point.

### Who built this?

Built inside Transformative Studio. The frameworks codify a body of work that traces to the InVision concept-video tradition. The skill exists to make that craft repeatable.

### Where can I see films made with this?

The first films will be linked from the [Transformative Studio](https://transformative.studio) website as they ship. The Harmony example in [`docs/EXAMPLES.md`](EXAMPLES.md) walks through the full process if you want to see what a real run looks like before trying it yourself.
