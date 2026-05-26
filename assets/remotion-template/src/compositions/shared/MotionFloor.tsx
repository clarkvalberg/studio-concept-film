import React from 'react';
import { AbsoluteFill, interpolate, useCurrentFrame, useVideoConfig } from 'remotion';
import { tokens } from './BrandTokens';

interface MotionFloorProps {
  durationSeconds: number;
  intensity?: 'subtle' | 'strong';
}

export const MotionFloor: React.FC<MotionFloorProps> = ({ durationSeconds, intensity = 'subtle' }) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();
  const totalFrames = Math.max(1, Math.round(durationSeconds * fps));
  const progress = frame / totalFrames;
  const drift = interpolate(frame, [0, totalFrames], [-42, 42], {
    extrapolateLeft: 'clamp',
    extrapolateRight: 'clamp',
  });
  const railX = interpolate(frame, [0, totalFrames], [12, 66], {
    extrapolateLeft: 'clamp',
    extrapolateRight: 'clamp',
  });
  const sweepX = interpolate(frame, [0, totalFrames], [-24, 124], {
    extrapolateLeft: 'clamp',
    extrapolateRight: 'clamp',
  });
  const accentSoft = tokens.color.accent.startsWith('#') && tokens.color.accent.length === 7
    ? `${tokens.color.accent}55`
    : `color-mix(in srgb, ${tokens.color.accent} 33%, transparent)`;
  const accentLine = tokens.color.accent.startsWith('#') && tokens.color.accent.length === 7
    ? `${tokens.color.accent}66`
    : `color-mix(in srgb, ${tokens.color.accent} 40%, transparent)`;
  const supportSoft = tokens.color.support.startsWith('#') && tokens.color.support.length === 7
    ? `${tokens.color.support}66`
    : `color-mix(in srgb, ${tokens.color.support} 40%, transparent)`;
  const sweepOpacity = intensity === 'strong' ? 0.58 : 0.18;
  const railOpacity = intensity === 'strong' ? 0.42 : 0.18;

  return (
    <AbsoluteFill style={{ pointerEvents: 'none', overflow: 'hidden' }}>
      <div
        style={{
          position: 'absolute',
          top: -120,
          bottom: -120,
          left: `${sweepX}%`,
          width: 520,
          opacity: sweepOpacity,
          transform: `translate3d(${drift}px, 0, 0) rotate(${2 + progress * 3}deg)`,
          background: `linear-gradient(90deg, transparent 0%, ${supportSoft} 50%, transparent 100%)`,
        }}
      />
      <div
        style={{
          position: 'absolute',
          left: '12%',
          right: '12%',
          bottom: 72,
          height: 1,
          opacity: railOpacity * 0.55,
          transform: `translate3d(${drift * -0.4}px, 0, 0) scaleX(${0.92 + progress * 0.08})`,
          transformOrigin: 'center',
          background: `linear-gradient(90deg, transparent, ${accentLine}, transparent)`,
        }}
      />
      <div
        style={{
          position: 'absolute',
          left: `${railX}%`,
          bottom: 68,
          width: 180,
          height: 3,
          borderRadius: 999,
          opacity: railOpacity,
          background: tokens.color.accent,
          transform: 'translate3d(-50%, 0, 0)',
        }}
      />
    </AbsoluteFill>
  );
};
