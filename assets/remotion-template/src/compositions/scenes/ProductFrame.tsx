import React from 'react';
import { AbsoluteFill, Img, staticFile, useCurrentFrame, useVideoConfig } from 'remotion';
import type { Section } from '../../types';
import { tokens } from '../shared/BrandTokens';
import { fadeInHoldOut, slowPushIn, easedTransition } from '../shared/motion';

interface Props { section: Section; }

/**
 * ProductFrame — single product screen, held and breathed.
 * Use for moments when one screen deserves the whole frame, not a montage.
 * Motion options: 'static' (no movement), 'slow-push-in' (subtle zoom),
 * 'parallax' (gentle vertical drift).
 */
export const ProductFrame: React.FC<Props> = ({ section }) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();
  const totalFrames = Math.round(section.duration * fps);
  const opacity = fadeInHoldOut(frame, totalFrames, 18);

  const motion = section.sceneProps.motion ?? 'slow-push-in';
  const src = section.sceneProps.screen
    ?? (typeof section.sceneProps.screens?.[0] === 'string'
      ? (section.sceneProps.screens?.[0] as string)
      : (section.sceneProps.screens?.[0] as { src?: string } | undefined)?.src);

  const scale =
    motion === 'static'
      ? 1
      : motion === 'parallax'
        ? 1.04
        : slowPushIn(frame, totalFrames);

  const translateY = motion === 'parallax'
    ? easedTransition(frame, 0, totalFrames, -20, 20)
    : 0;

  return (
    <AbsoluteFill
      style={{
        backgroundColor: tokens.color.background,
        opacity,
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        padding: 96,
      }}
    >
      <div
        style={{
          maxWidth: '82%',
          maxHeight: '82%',
          transform: `scale(${scale}) translateY(${translateY}px)`,
          transformOrigin: 'center center',
          boxShadow: '0 40px 80px rgba(0,0,0,0.20), 0 12px 24px rgba(0,0,0,0.10)',
          borderRadius: 14,
          overflow: 'hidden',
          background: '#fff',
        }}
      >
        {src ? (
          <Img
            src={staticFile(src)}
            style={{ width: '100%', height: 'auto', display: 'block' }}
          />
        ) : (
          <div
            style={{
              width: 1200,
              height: 720,
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              color: tokens.color.support,
              fontFamily: 'monospace',
              fontSize: 22,
              border: `2px dashed ${tokens.color.support}`,
            }}
          >
            [product screen — set sceneProps.screen]
          </div>
        )}
      </div>
    </AbsoluteFill>
  );
};
