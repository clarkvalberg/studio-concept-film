// motion.ts — Animation helpers for concept film scenes.
//
// All scene components import from this file rather than defining inline easing.
// This ensures consistent motion language across the film.

import { interpolate, spring, useCurrentFrame, useVideoConfig } from 'remotion';
import { tokens } from './BrandTokens';

const FPS = 30; // overridden by useVideoConfig but used in static helpers

/**
 * Convert seconds → frames given a known fps.
 */
export const s = (seconds: number, fps: number = FPS): number => Math.round(seconds * fps);

/**
 * Smooth fade-in over a window of frames.
 * Returns opacity [0..1].
 */
export const fadeIn = (frame: number, startFrame: number, durationFrames: number): number =>
  interpolate(frame, [startFrame, startFrame + durationFrames], [0, 1], {
    extrapolateLeft: 'clamp',
    extrapolateRight: 'clamp',
  });

/**
 * Smooth fade-out over a window of frames.
 */
export const fadeOut = (frame: number, startFrame: number, durationFrames: number): number =>
  interpolate(frame, [startFrame, startFrame + durationFrames], [1, 0], {
    extrapolateLeft: 'clamp',
    extrapolateRight: 'clamp',
  });

/**
 * Fade in, hold, fade out — the most common scene element animation.
 * Returns opacity [0..1] across the full lifetime.
 */
export const fadeInHoldOut = (
  frame: number,
  totalFrames: number,
  fadeFrames: number = 18
): number => {
  if (frame < fadeFrames) return fadeIn(frame, 0, fadeFrames);
  if (frame > totalFrames - fadeFrames) return fadeOut(frame, totalFrames - fadeFrames, fadeFrames);
  return 1;
};

/**
 * Slow push-in: scale from 1.0 to 1.08 over the whole scene duration.
 * Used for held images in the cold open.
 */
export const slowPushIn = (frame: number, totalFrames: number): number =>
  interpolate(frame, [0, totalFrames], [1.0, 1.08], { extrapolateRight: 'clamp' });

/**
 * Springy entrance — used for kinetic type words.
 */
export const useSpringEntrance = (delayFrames: number = 0, mass: number = 0.8) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();
  return spring({
    frame: frame - delayFrames,
    fps,
    config: { mass, damping: 12, stiffness: 100 },
  });
};

/**
 * Eased transition between two values across a window of frames.
 */
export const easedTransition = (
  frame: number,
  startFrame: number,
  durationFrames: number,
  from: number,
  to: number
): number =>
  interpolate(frame, [startFrame, startFrame + durationFrames], [from, to], {
    extrapolateLeft: 'clamp',
    extrapolateRight: 'clamp',
  });

export { tokens };
