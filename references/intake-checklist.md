# Intake Checklist

Used in Phase 1. The goal of intake is to produce a two-sentence concept summary that the user confirms is correct. Everything downstream depends on this.

## What you're looking for, regardless of input type

Extract these six elements from the source material. If any is missing after a thorough read, surface it explicitly — don't guess.

1. **What is it?** One sentence. Product category, primary function, what it actually does.
2. **Who is it for?** Specific audience. Not "everyone." Not "businesses." A person you can picture.
3. **What problem does it solve?** The friction in the current world. Concrete, not abstract.
4. **What's the insight?** The non-obvious thing the team has seen that explains why this product can exist now. (If there isn't one, the concept may not be ready for a concept film.)
5. **What's the form factor?** Mobile app, web app, embedded service, hardware, network — how the user touches it.
6. **What stage is it?** Concept, prototype, in market, scaling. Affects how concrete the product walk can be.

If you can't fill 1, 2, 3, 5 from the source material, ask. If 4 and 6 are missing, flag but proceed — you can extract or assume.

## Per input type

### Brief / research doc / memo (MD, DOCX, PDF, plaintext)

- Read the entire document. Do not skim.
- Look for: the founder's own framing of the problem, customer interview quotes, the team's stated insight, any "we believe" statements
- Watch for: jargon that disguises vagueness. If a doc says "AI-powered platform for X," translate to plain English before continuing
- Quote the strongest 1–2 sentences from the source — these often become script anchors

### Prototype (Figma link, deployed URL, screenshots)

- For Figma: extract via Figma MCP if available. Identify the main screens and their order. Note the brand system (typography, color, spacing).
- For deployed URL: web_fetch and walk the primary user journey. Note the language used in the product copy — this is the team's voice, and the film should match.
- For screenshots: identify which screens cover which moments of the user experience. Note what's missing (often onboarding, edge states, or the moment after the action).
- Always note: does the prototype show *the ontology*? (The core nouns and verbs of the product.) The product walk needs this.

### Deck (PPTX, PDF export, Keynote)

- The deck is usually richer than the team thinks it is. Read every slide, including appendix.
- Look specifically for: the team's narrative arc (decks often have a built-in story), competitive framing (helps with what the film should *not* claim), traction slides (tells you what's real vs aspirational)
- Pull the most visually striking slide — sometimes it becomes a cold-open reference

### Website (URL)

- web_fetch the homepage plus 2–3 key sub-pages
- The website's hero copy is the team's current public framing. The film can match it, sharpen it, or deliberately diverge — but you should know what it says.
- Note the visual identity carefully: type, color, motion, photography style. This feeds Phase 4 directly.

### Loose description (the user typing it)

- This is the weakest input. Ask for one concrete thing if possible: a screenshot, a one-paragraph brief, a competitor URL the team is inspired by.
- If the user only has the verbal description, work with it but lower confidence on the legibility gate. Surface a draft summary and ask for direct confirmation.

## The two-sentence summary format

The summary you produce in Phase 1 should follow this shape:

> **Sentence 1:** [Product name] is [category] for [specific audience] that [primary function/value].
>
> **Sentence 2:** [What's distinctive — the insight, the timing, or the structural advantage that explains why this exists.]

**Example (Signatures.law):**

> Signatures.law is a web app for real estate closing teams that turns an unsorted stack of closing PDFs into reviewed signature-page packets: recording pages for wet-ink filing and non-recording pages for DocuSign.
>
> Its wedge is that the painful work is not just extraction, but legal return-path classification plus auditability: every AI classification, correction, output PDF, checklist, and document fingerprint becomes part of a defensible chain-of-custody record.

## The minimum prototype surface

After the summary, name what screens the video needs. This is a service to the user — they often don't know what's needed until you say it.

The minimum surface for a concept film is usually:

1. **The entry point** — what the user sees first (home, dashboard, landing)
2. **The core ontology screen** — the screen that shows what the product is *about*. The main object, the main canvas, the main artifact.
3. **The action moment** — the screen where the user does the thing the product exists to enable
4. **The result state** — what success looks like

For a 90s film, four screens is enough. Six is comfortable. More than eight and the product walk gets cluttered.

If the prototype is missing pieces, name them: "To make this film land, I'd want screens showing [X, Y, Z]. If those don't exist yet, I can use schematic stand-ins, but the film will work harder when we have the real thing."

## The legibility gate — what passes, what doesn't

**Passes the gate:**
- You can summarize the concept in two sentences
- The user confirms the summary
- The audience and problem are specific
- The product has a stage and form factor

**Doesn't pass:**
- You're writing "an AI platform that helps users…" — too vague
- The audience is "businesses" or "consumers" or "everyone"
- The problem isn't articulable in plain English
- The product is purely speculative ("imagine an app that…")

If the gate fails, name what's missing in one direct sentence and ask the user to fill it. Do not loop. One question, then proceed once answered.
