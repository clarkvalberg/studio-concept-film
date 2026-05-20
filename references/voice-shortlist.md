# Voice Shortlist

Used in Phase 5. This is the curated list of ElevenLabs voices for studio concept films. The list is short by design — curation is the value, not breadth.

## Why a shortlist (and not the full ElevenLabs library)

ElevenLabs has thousands of voices. Most of them don't fit the concept-film genre. They're either too announcer-y (sales/advertising tone), too monotone (audiobook neutral), or too eccentric (character voices). A shortlist of 8–12 well-chosen voices produces better outcomes than letting the user wade through hundreds.

The shortlist is also the skill's taste signature. When other people install this skill, they should hear the curated voices as part of what they're getting — not as a constraint.

## The eight curated voices

Voices marked with ★ are the most flexible and the most often correct first guess.

### ★ Rachel — warm, observational, the documentary register

- Voice ID: `21m00Tcm4TlvDq8ikWAM`
- Recommended model: `eleven_v3` or `eleven_multilingual_v2`
- Best for: Customer-led films, films with human moments, any film where warmth is needed without performative softness
- Avoid for: aggressive Demo-led opens, B2B films where the concept's edge is conceptual rather than emotional
- Suggested settings: `stability: 0.5, similarity_boost: 0.75, style: 0.3`

> "It's the 14th of the month. Russ has 312 compliance documents on his desk."

She lands the specifics without sentimentalizing them. The single best default for this genre.

### ★ Brian — grounded, confident, the long-form documentary narrator

- Voice ID: `nPczCjzI2devNBz1zQrb`
- Recommended model: `eleven_v3`
- Best for: Insight-led films, B2B platforms, films where the script makes a structural argument
- Avoid for: anything that should feel intimate; he's too institutional for human-moment opens
- Suggested settings: `stability: 0.6, similarity_boost: 0.7, style: 0.2`

> "Every affordable housing project in America gets built the same way: badly."

He sells assertions as observations. Great when the script has confident factual lines.

### Adam — cinematic, slightly aspirational, the trailer voice (without the trailer-voice problem)

- Voice ID: `pNInz6obpgDQGcFmaJgB`
- Recommended model: `eleven_v3`
- Best for: Vision-statement-heavy films, films with grand-but-grounded ambition, Demo-led films where the product is doing the asserting
- Avoid for: intimate or human-moment films — he runs hot for that register
- Suggested settings: `stability: 0.55, similarity_boost: 0.7, style: 0.4`

> "This is Harmony."

His brevity is a strength. Don't make him read long sentences.

### Charlotte — intimate, present, the close-up voice

- Voice ID: `XB0fDUnXU5powFXDhCwa`
- Recommended model: `eleven_v3`
- Best for: Customer-led films opening on a person, films about services or experiences, films where the audience needs to feel like they're being told something rather than pitched
- Avoid for: institutional pitches, anything where authority needs to lead
- Suggested settings: `stability: 0.5, similarity_boost: 0.75, style: 0.35`

> "Maria refreshes the page for the eleventh time."

Hers is the voice that makes the viewer lean in. Use sparingly — she works best when the film earns the intimacy.

### Daniel — authoritative, measured, the institutional voice

- Voice ID: `onwK4e9ZLuTAKqWW03F9`
- Recommended model: `eleven_v3` or `eleven_multilingual_v2`
- Best for: LP-facing films, films aimed at boards or institutional audiences, films where the audience starts skeptical
- Avoid for: consumer-facing concepts, anything that should feel warm
- Suggested settings: `stability: 0.65, similarity_boost: 0.7, style: 0.15`

> "There are 2.3 million units like this in the country."

He makes facts feel inevitable.

### Antoni — warm, optimistic, the friend's-voice register

- Voice ID: `ErXwobaYiN019PkySvjV`
- Recommended model: `eleven_v3`
- Best for: Films about products that serve people directly (healthcare, education, services), Customer-led films, internal team films
- Avoid for: anything that needs distance or institutional weight
- Suggested settings: `stability: 0.5, similarity_boost: 0.75, style: 0.35`

> "Marcus sees twelve patients a day. None of them come to him."

His warmth doesn't tip into performance. Reliable when the film needs emotional accessibility.

### Lily — clear, professional, the "trustworthy expert" register

- Voice ID: `pFZP5JQG7iQjIQuC4Bku`
- Recommended model: `eleven_v3` or `eleven_multilingual_v2`
- Best for: Films with technical or regulatory subjects (healthcare, compliance, financial services), films where credibility is part of the argument
- Avoid for: emotive customer-led opens; she's too composed for that
- Suggested settings: `stability: 0.6, similarity_boost: 0.7, style: 0.2`

> "Every dollar of LIHTC compliance costs the operator $4 to defend."

She makes specifics carry weight without dramatizing them.

### Will — measured, slightly wry, the "thoughtful colleague" register

- Voice ID: `bIHbv24MWmeRgasZH58o`
- Recommended model: `eleven_v3`
- Best for: Insight-led films with a contrarian or counterintuitive thesis, films aimed at sophisticated audiences who'd resist over-earnestness
- Avoid for: customer-led films opening on personal moments
- Suggested settings: `stability: 0.55, similarity_boost: 0.72, style: 0.25`

> "Most software is still built around the assumption that someone is typing."

His slight wryness makes him forgiving of confident claims.

## How to pick four for the audition

The user hears four samples in Phase 5, not eight. Picking the four is the skill's taste exercise.

### The selection rule

Pick four voices that bracket the **range** the script could live in, not four voices that are similar.

For a customer-led script about a clinician (mobile medical care):
- Antoni (warm, accessible — likely fit)
- Charlotte (intimate — could elevate the open)
- Rachel (warm-observational — strong default)
- Daniel (institutional — what if we play it more measured?)

The fourth slot — the contrarian — is important. It surfaces the user's actual preference by giving them something to react against. Don't waste it on a close variant of slots 1–3.

### The selection logic by variant

**Customer-led** — Rachel, Charlotte, Antoni, plus one of: Daniel (counterpoint) or Brian (counterpoint)

**Insight-led** — Brian, Will, Rachel, plus one of: Daniel (more institutional) or Adam (more aspirational)

**Demo-led** — Adam, Brian, Rachel, plus one of: Will (less assertive) or Daniel (more measured)

These are starting points, not rules. Read the script and adjust.

## Voice settings — what they do

The three settings that matter:

- **Stability** (0–1) — higher means more consistent, lower means more emotionally variable. For concept films, 0.5–0.65 is the working range. Below 0.5 the voice gets unpredictable; above 0.7 it flattens.
- **Similarity boost** (0–1) — how closely to match the original training voice. For concept films, 0.7–0.75 produces a present, controlled performance. Higher can sound stiff.
- **Style** (0–1) — emotional expressiveness. 0.2–0.4 is the concept-film register. Above 0.5 it tips into performance.

These are not absolute. Tune per voice — some voices need slightly different settings to land. The values in each voice entry above are working defaults, not commandments.

## Generating the audition samples

Use `scripts/audition.sh` (or call `ElevenLabs Player:generate_tts` directly if running interactively):

```bash
./scripts/audition.sh \
  --script "It's the 14th of the month. Russ has 312 compliance documents on his desk." \
  --voices "Rachel,Brian,Charlotte,Antoni" \
  --output ./voice-auditions/
```

The script outputs four mp3 files plus an HTML preview that plays them inline.

For the audition line, use the first 10–15 seconds of the actual script (the cold open). Don't use a generic test sentence — the user needs to hear the voice carrying *their* words.

## When the user wants something not on the list

If the user asks for a voice not in the shortlist:

1. Acknowledge their preference
2. Add the voice for *this* project (don't replace the shortlist permanently)
3. Note in `voice.json`: "Added [voice] per user request; not in default shortlist"
4. Offer: "Want me to add this to the default shortlist for future runs?"

The shortlist is the skill's taste signature, but it's not inflexible. Users have ears.

## When ElevenLabs isn't connected

If the user's environment doesn't have an ElevenLabs API key or the Player MCP:

1. Output the four recommended voices with their IDs and one-line justifications
2. Provide a link to elevenlabs.io/voices/ where the user can preview each manually
3. Save the user's selection (by name) to `voice.json` with a flag: `"audio_pending": true`
4. The Remotion template renders with silent audio tracks; user can re-render once audio is generated

Don't break the flow chasing a connection that isn't there. The film can be designed in full and audio added at the end.
