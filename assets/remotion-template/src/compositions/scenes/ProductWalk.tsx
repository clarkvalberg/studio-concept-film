import React from 'react';
import { AbsoluteFill, Img, staticFile, useCurrentFrame, useVideoConfig, interpolate } from 'remotion';
import type { Section, ScreenSpec } from '../../types';
import { tokens } from '../shared/BrandTokens';
import { Caption } from '../shared/Typography';
import { fadeInHoldOut } from '../shared/motion';

interface Props { section: Section; }

/**
 * ProductWalk — Establish → Operate → Reveal.
 * Each screen gets its own micro-beat with a labeled phase.
 */
export const ProductWalk: React.FC<Props> = ({ section }) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();
  const totalFrames = Math.round(section.duration * fps);
  const opacity = fadeInHoldOut(frame, totalFrames, 16);

  const screens = (section.sceneProps.screens ?? []) as (string | ScreenSpec)[];

  // Distribute screens by their dwell times if specified, otherwise even split
  const dwellTimes = screens.map((s) => (typeof s === 'string' ? section.duration / screens.length : s.dwell ?? section.duration / screens.length));
  const cumulativeDwell: number[] = [];
  dwellTimes.reduce((acc, d, i) => {
    cumulativeDwell[i] = acc + d;
    return acc + d;
  }, 0);

  const seconds = frame / fps;
  let currentIdx = 0;
  for (let i = 0; i < cumulativeDwell.length; i++) {
    if (seconds < cumulativeDwell[i]) { currentIdx = i; break; }
    currentIdx = i;
  }

  const current = screens[currentIdx];
  const src = typeof current === 'string' ? current : current?.src;
  const label = typeof current === 'string' ? null : current?.label;

  return (
    <AbsoluteFill
      style={{
        backgroundColor: tokens.color.background,
        opacity,
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        justifyContent: 'center',
        padding: 96,
      }}
    >
      {src ? (
        <div
          style={{
            maxWidth: '78%',
            maxHeight: '70%',
            boxShadow: '0 30px 60px rgba(0,0,0,0.18), 0 8px 16px rgba(0,0,0,0.08)',
            borderRadius: 12,
            overflow: 'hidden',
            background: '#fff',
          }}
        >
          <Img
            src={staticFile(src)}
            style={{ width: '100%', height: 'auto', display: 'block' }}
          />
        </div>
      ) : (
        <div
          style={{
            width: '78%',
            height: '70%',
            border: `2px dashed ${tokens.color.support}`,
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            color: tokens.color.support,
            fontFamily: 'monospace',
            fontSize: 22,
          }}
        >
          [product screen — add to sceneProps.screens]
        </div>
      )}

      {label && (
        <div style={{ marginTop: 32 }}>
          <Caption uppercase color="accent" size={20} align="center">
            {label}
          </Caption>
        </div>
      )}
    </AbsoluteFill>
  );
};
