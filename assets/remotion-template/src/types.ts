// Types — the data contract between the studio-concept-film skill and this template.
// The skill writes a FilmData object to src/data/film.ts; this template reads it.

export type Variant = 'customer-led' | 'insight-led' | 'demo-led';

export type SceneType =
  | 'CustomerMoment'
  | 'InsightCard'
  | 'ProblemFrame'
  | 'ProductWalk'
  | 'ProductFrame'
  | 'VisionClose'
  | 'KineticType'
  | 'ScreenCallout';

export interface ScreenSpec {
  src: string;
  label?: string;
  dwell?: number;
}

export interface SceneProps {
  // CustomerMoment
  imagery?: string;
  composition?: 'close-up' | 'medium' | 'wide';
  light?: string;
  motion?: 'slow-push-in' | 'static' | 'parallax';

  // InsightCard / KineticType
  kineticPhrase?: string;
  phrase?: string;
  treatment?: string;
  background?: 'background' | 'ink' | 'accent';

  // ProblemFrame / ProductWalk / ProductFrame / ScreenCallout
  screens?: (string | ScreenSpec)[];
  pacing?: 'cuts-on-beats' | 'slow-pan' | 'kinetic';
  microStructure?: 'establish-operate-reveal' | 'list' | 'narrative';
  screen?: string;
  callouts?: { x: number; y: number; label: string }[];

  // VisionClose
  finalImage?: string;
  logoReveal?: 'centered-fade' | 'left-aligned' | 'kinetic';
  tagline?: string;

  // catch-all for any extras (don't abuse)
  [key: string]: unknown;
}

export interface Section {
  id: string;
  sceneType: SceneType;
  start: number;          // seconds, from film start
  duration: number;       // seconds
  vo: string;
  sceneProps: SceneProps;
}

export interface FilmData {
  meta: {
    projectName: string;
    variant: Variant;
    totalDuration: number;  // seconds
    fps: number;
    width: number;
    height: number;
  };
  voice: {
    voiceId: string | null;
    voiceName: string | null;
    hookAudio: string;
    fullAudio: string;
  };
  sections: Section[];
}
