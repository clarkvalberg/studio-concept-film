// film.ts — Project-specific data, written by the studio-concept-film skill.
//
// THIS IS THE PLACEHOLDER. The skill replaces this file with project-specific data
// during Phase 6. Do not edit by hand unless you're iterating on a rendered film.

import type { FilmData } from '../types';

export const film: FilmData = {
  meta: {
    projectName: 'Placeholder',
    variant: 'customer-led',
    totalDuration: 75,
    fps: 30,
    width: 1920,
    height: 1080,
  },
  voice: {
    voiceId: null,
    voiceName: null,
    hookAudio: '/audio/hook.mp3',
    fullAudio: '/audio/voiceover.mp3',
  },
  sections: [
    {
      id: 'cold-open',
      sceneType: 'CustomerMoment',
      start: 0,
      duration: 8,
      vo: 'Cold open voiceover line goes here.',
      sceneProps: {
        imagery: 'placeholder',
        composition: 'close-up',
        light: 'warm-tungsten',
        motion: 'slow-push-in',
      },
    },
    {
      id: 'problem',
      sceneType: 'ProblemFrame',
      start: 8,
      duration: 14,
      vo: 'Problem section voiceover.',
      sceneProps: {
        screens: [],
        treatment: 'desaturated',
        pacing: 'cuts-on-beats',
      },
    },
    {
      id: 'insight',
      sceneType: 'InsightCard',
      start: 22,
      duration: 13,
      vo: 'Insight section voiceover. This is the turn.',
      sceneProps: {
        kineticPhrase: 'a choice',
        treatment: 'clean-shift',
        background: 'background',
      },
    },
    {
      id: 'product-walk',
      sceneType: 'ProductWalk',
      start: 35,
      duration: 30,
      vo: 'Product walk voiceover. Establish, operate, reveal.',
      sceneProps: {
        screens: [],
        microStructure: 'establish-operate-reveal',
      },
    },
    {
      id: 'vision-close',
      sceneType: 'VisionClose',
      start: 65,
      duration: 10,
      vo: 'Vision close. Brand name.',
      sceneProps: {
        finalImage: 'placeholder',
        logoReveal: 'centered-fade',
        tagline: 'Brand.',
      },
    },
  ],
};
