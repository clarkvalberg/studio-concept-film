# Contributing

Thanks for being here.

This repo is opinionated. The opinions are the IP. Contributions that sharpen the opinions are welcome. Contributions that dilute them are not.

Read this document before opening a PR — it will save both of us time.

---

## What this repo is for

A Claude skill that produces 60–90 second concept films in the InVision-lineage tradition. The scope is narrow on purpose. See [docs/PHILOSOPHY.md](docs/PHILOSOPHY.md) for the manifesto and [SKILL.md](SKILL.md) for the operating manual.

## What kinds of changes fit

### Welcome

- **Sharper framework guidance.** If you've made concept films that worked and noticed something the existing frameworks miss, surface it. Add to `references/frameworks.md` or `references/script-rules.md`.
- **New scene types.** If your concept film needed something the eight existing scenes couldn't render, build it in `assets/remotion-template/src/compositions/scenes/`, register it in `SceneRenderer.tsx`, and update the type union in `types.ts`. Include a short description of when to use it.
- **Voice shortlist additions or refinements.** If you've found a voice that consistently works for a register the current eight don't cover, propose it. Include the ElevenLabs voice ID, fit notes, and the kind of brief it serves.
- **Banned word additions** with reasoning. If a word has joined the exhausted-language pile, name it and explain why.
- **Better worked examples.** Concrete walkthroughs in `docs/EXAMPLES.md` make the skill easier to learn. Anonymize as needed; keep the structure.
- **Documentation fixes.** Typos, broken links, outdated paths, misleading sentences.
- **Bug fixes** in the scripts or Remotion template.

### Not welcome

- **Generalizing the skill into a broader video tool.** Adding "marketing ad" support or "tutorial" support or "social post" support is a project fork, not a contribution. The narrowness is the value.
- **Choice-expanding changes.** Adding a fourth structural variant, or a fifth direction archetype, or a ninth voice without justifying why the existing curation is insufficient. Curation is the product.
- **Lowering the gate.** Removing the legibility gate, the hook-render-before-full rule, the banned words list, or the three-question cap. These exist for specific failure modes.
- **Stylistic drift in the documentation.** This repo has a voice. Documentation contributions should match it. If your prose introduces "leverage," "seamlessly," or "powerful," it will be edited or rejected.

If you're unsure whether a change fits, **open an issue first** and describe what you're thinking. Cheaper for both of us than a PR that gets closed.

---

## How to contribute

1. **Open an issue** describing the change you want to make. For small fixes (typos, broken links), you can skip this step and open a PR directly.
2. **Fork the repo** and create a branch off `main`. Name it descriptively (`scene-comparison-frame` not `update-1`).
3. **Make your change**, keeping commits focused and well-described.
4. **Test it locally:**
   - For changes to scripts: `shellcheck scripts/*.sh`
   - For changes to the Remotion template: `cd assets/remotion-template && npx tsc --noEmit`
   - For changes to references or docs: read them back end-to-end. If they don't flow, they don't ship.
5. **Open a PR** against `main`. Use the PR template. Explain what changed and why.

---

## Code style

### TypeScript / TSX

- Match the existing style — 2-space indent, semicolons, single quotes
- Prefer functional components, hooks, named exports
- Type everything; avoid `any` (use `unknown` if truly unsure)
- New scene components: copy the props/structure of an existing scene as a template

### Bash scripts

- `#!/usr/bin/env bash` with `set -euo pipefail`
- Comment the header: usage, dependencies, what it produces
- Use `[[` for tests, `$(...)` for substitution
- Quote variables: `"$PROJECT_DIR"` not `$PROJECT_DIR`
- Pass `shellcheck` cleanly

### Markdown

- Keep paragraphs short. The form of the documentation is part of the message.
- Use tables for parallel data, not lists
- Code blocks should be runnable as-shown; if they have placeholders, mark them clearly
- One blank line between paragraphs, two before headers
- Avoid emojis unless they're load-bearing (and they almost never are)

### Voice

- Direct. Confident. No hedging language ("might be useful to consider perhaps...").
- Specific over general. Concrete examples beat abstract principles.
- No marketing register. The reader is an intelligent peer.
- If a sentence could appear in a SaaS landing page, it probably shouldn't appear here.

---

## Commit messages

Use [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) format:

```
type(scope): short description

Optional longer description.
```

Common types: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`.

Examples:

```
feat(scenes): add ComparisonFrame for side-by-side product moments
fix(scripts): handle paths with spaces in init-project.sh
docs(faq): clarify the difference between hook and full render
```

---

## Reporting bugs

Use the bug report template. Include:

- What you did
- What you expected to happen
- What actually happened
- Your environment (OS, Node version, Claude environment)
- Logs or screenshots if relevant

---

## Asking questions

For usage questions, check [docs/FAQ.md](docs/FAQ.md) first. If your question isn't covered, open a Discussion (not an Issue) so the answer is searchable for the next person.

For deep design questions about the frameworks or the philosophy, open an Issue. We'd rather have those conversations in public.

---

## A note on humans and AI

This skill was built by a human (Clark, inside Transformative Studio) with the assistance of Claude. Contributions can come from either. Use whatever tools help you do good work. The bar for what gets merged is the same: does it sharpen the opinions, hold up the voice, and make the films better?

---

## License

By contributing, you agree that your contributions will be licensed under the MIT License. See [LICENSE](LICENSE).
