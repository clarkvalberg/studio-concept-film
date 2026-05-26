# Concept Film — HyperFrames Template

This HyperFrames project is the rendering layer for `studio-video-creator`.
The skill copies it into a project directory, writes `data/film.json` and
`data/tokens.json`, then renders the thumbnail, hook, and full film.

## Commands

```bash
npm run dev
npm run check
npm run render:hook
npm run render:full
```

The skill scripts call HyperFrames directly, so you usually do not need to run
these commands by hand.
