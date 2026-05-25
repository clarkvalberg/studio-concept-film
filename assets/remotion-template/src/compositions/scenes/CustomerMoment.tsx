import React from 'react';
import { AbsoluteFill, Img, staticFile, useCurrentFrame, useVideoConfig } from 'remotion';
import type { Section } from '../../types';
import { tokens } from '../shared/BrandTokens';
import { fadeInHoldOut, slowPushIn } from '../shared/motion';

interface Props { section: Section; }

/**
 * CustomerMoment — opening scene showing a person, place, or lived moment.
 * Slow push-in on a still image, ambient warmth, no text overlay.
 * The voiceover lags the image — let it breathe for 2-3s.
 */
export const CustomerMoment: React.FC<Props> = ({ section }) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();
  const totalFrames = Math.round(section.duration * fps);

  const opacity = fadeInHoldOut(frame, totalFrames, 24);
  const scale = section.sceneProps.motion === 'static' ? 1 : slowPushIn(frame, totalFrames);

  const imagery = typeof section.sceneProps.imagery === 'string' ? section.sceneProps.imagery : null;
  const imageSrc = imagery && imagery !== 'placeholder'
    ? `/imagery/${imagery}.jpg`
    : null;

  return (
    <AbsoluteFill style={{ backgroundColor: tokens.color.ink, overflow: 'hidden' }}>
      <AbsoluteFill
        style={{
          opacity,
          transform: `scale(${scale})`,
          transformOrigin: 'center center',
        }}
      >
        {imageSrc ? (
          <Img
            src={staticFile(imageSrc)}
            style={{
              width: '100%',
              height: '100%',
              objectFit: 'cover',
            }}
          />
        ) : (
          <AbsoluteFill
            style={{
              backgroundColor: tokens.color.ink,
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              fontFamily: 'monospace',
              color: tokens.color.support,
              fontSize: 24,
              opacity: 0.5,
            }}
          >
            [imagery: {String(section.sceneProps.imagery ?? 'placeholder')}]
          </AbsoluteFill>
        )}
      </AbsoluteFill>

      {/* Subtle vignette */}
      <AbsoluteFill
        style={{
          pointerEvents: 'none',
          background:
            'radial-gradient(circle at center, rgba(0,0,0,0) 55%, rgba(0,0,0,0.35) 100%)',
        }}
      />
    </AbsoluteFill>
  );
};
