import React from 'react';
import { AbsoluteFill, Img, staticFile, useCurrentFrame, useVideoConfig, interpolate } from 'remotion';
import type { Section, ScreenSpec } from '../../types';
import { tokens } from '../shared/BrandTokens';
import { fadeInHoldOut } from '../shared/motion';

interface Props { section: Section; }

/**
 * ProblemFrame — multi-screen montage establishing the friction in the world.
 * Quick cuts on beats, desaturated treatment by default.
 */
export const ProblemFrame: React.FC<Props> = ({ section }) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();
  const totalFrames = Math.round(section.duration * fps);
  const opacity = fadeInHoldOut(frame, totalFrames, 14);

  const screens = (section.sceneProps.screens ?? []) as (string | ScreenSpec)[];
  const desaturate = section.sceneProps.treatment === 'desaturated';

  // Evenly distribute the screens across the section duration
  const slotDuration = screens.length > 0 ? totalFrames / screens.length : totalFrames;
  const currentSlot = Math.min(Math.floor(frame / slotDuration), Math.max(screens.length - 1, 0));
  const current = screens[currentSlot];
  const src = typeof current === 'string' ? current : current?.src;

  // Cross-fade between slots
  const slotProgress = (frame % slotDuration) / slotDuration;
  const slotOpacity = interpolate(slotProgress, [0, 0.1, 0.9, 1], [0, 1, 1, 0], {
    extrapolateLeft: 'clamp',
    extrapolateRight: 'clamp',
  });

  return (
    <AbsoluteFill style={{ backgroundColor: tokens.color.background, opacity }}>
      {src ? (
        <AbsoluteFill style={{ opacity: slotOpacity }}>
          <Img
            src={staticFile(src)}
            style={{
              width: '100%',
              height: '100%',
              objectFit: 'cover',
              filter: desaturate ? 'saturate(0.4) contrast(0.95)' : 'none',
            }}
          />
        </AbsoluteFill>
      ) : (
        <AbsoluteFill
          style={{
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            color: tokens.color.ink,
            fontFamily: 'monospace',
            fontSize: 22,
            opacity: 0.4,
          }}
        >
          [problem screens — add to sceneProps.screens]
        </AbsoluteFill>
      )}
    </AbsoluteFill>
  );
};
