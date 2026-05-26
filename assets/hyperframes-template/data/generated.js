window.STUDIO_TOKENS = {
  "typography": {
    "display": {
      "family": "Inter",
      "weight": 720,
      "fallback": "system-ui, sans-serif"
    },
    "body": {
      "family": "Inter",
      "weight": 400,
      "fallback": "system-ui, sans-serif"
    },
    "mono": {
      "family": "JetBrains Mono",
      "weight": 400,
      "fallback": "ui-monospace, monospace"
    }
  },
  "color": {
    "background": "#F4EFE6",
    "ink": "#1A1614",
    "accent": "#2E6F5E",
    "support": "#C9B89A",
    "surface": "#FFF9EF",
    "muted": "#6F675E"
  },
  "motion": {
    "entrance": "power3.out",
    "exit": "power2.in",
    "transition": "power2.inOut",
    "durations": {
      "fast": 0.25,
      "medium": 0.45,
      "slow": 0.75,
      "hold": 1.5
    }
  },
  "spacing": {
    "unit": 8
  }
};
window.STUDIO_FILM = {
  "meta": {
    "projectName": "Untitled",
    "variant": "insight-led",
    "totalDuration": 75,
    "fps": 30,
    "width": 1920,
    "height": 1080
  },
  "voice": {
    "voiceId": "",
    "voiceName": "",
    "hookAudio": "audio/hook.mp3",
    "fullAudio": "audio/voiceover.mp3"
  },
  "sections": [
    {
      "id": "cold-open",
      "sceneType": "KineticType",
      "start": 0,
      "duration": 8,
      "vo": "A concept becomes real when people can see what changes.",
      "sceneProps": {
        "eyebrow": "Cold Open",
        "visualAction": "A short phrase enters, locks, and reveals the project name.",
        "beforeState": "The concept is abstract.",
        "afterState": "The concept has a first frame.",
        "productProof": "Project title and thesis.",
        "motionMode": "kinetic-type",
        "kineticPhrase": "Make it legible."
      }
    },
    {
      "id": "problem",
      "sceneType": "ProblemFrame",
      "start": 8,
      "duration": 12,
      "vo": "The work is not just making a video. It is choosing the right first impression.",
      "sceneProps": {
        "eyebrow": "Problem",
        "visualAction": "Three proof cards enter as a structured argument.",
        "beforeState": "The viewer has scattered context.",
        "afterState": "The viewer sees the shape of the argument.",
        "productProof": "Script, design, and motion gates.",
        "motionMode": "object-flow"
      }
    },
    {
      "id": "vision-close",
      "sceneType": "VisionClose",
      "start": 20,
      "duration": 10,
      "vo": "A short film that makes the product easier to understand.",
      "sceneProps": {
        "eyebrow": "Vision",
        "visualAction": "The argument resolves into a clean title card.",
        "beforeState": "Separate beats.",
        "afterState": "One finished concept film.",
        "productProof": "Final lockup.",
        "motionMode": "lockup-hold",
        "tagline": "Studio concept film."
      }
    }
  ]
};
