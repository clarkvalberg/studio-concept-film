# Concept Film — HyperFrames Template

This HyperFrames project is the optional HTML/GSAP rendering layer for
`studio-video-creator`. Remotion is the default renderer. Choose HyperFrames
when a browser-native HTML/CSS/JS project is the better artifact. The skill
copies it into a project directory, writes `data/film.json` and
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
