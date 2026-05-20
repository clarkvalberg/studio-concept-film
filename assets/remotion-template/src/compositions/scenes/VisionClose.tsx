import React from 'react';
import { AbsoluteFill, Img, staticFile, useCurrentFrame, useVideoConfig, interpolate } from 'remotion';
import type { Section } from '../../types';
import { tokens } from '../shared/BrandTokens';
import { Display, Caption } from '../shared/Typography';
import { fadeIn, fadeInHoldOut, slowPushIn } from '../shared/motion';

interface Props { section: Section; }

/**
 * VisionClose — the closing beat. Earned aspiration.
 * Structure: optional final image, then brand mark + tagline.
 * The brand mark appears late (~70% through the section).
 */
export const VisionClose: React.FC<Props> = ({ section }) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();
  const totalFrames = Math.round(section.duration * fps);

  const imageSrc = section.sceneProps.finalImage
    ? `/imagery/${section.sceneProps.finalImage}.jpg`
    : null;

  // Phase 1: image (0% → 65%)
  const imagePhaseEnd = Math.round(totalFrames * 0.65);
  const imageOpacity = interpolate(
    frame,
    [0, 24, imagePhaseEnd - 18, imagePhaseEnd],
    [0, 1, 1, 0],
    { extrapolateLeft: 'clamp', extrapolateRight: 'clamp' }
  );
  const imageScale = slowPushIn(frame, totalFrames);

  // Phase 2: brand mark (65% → end)
  const brandStart = imagePhaseEnd;
  const brandOpacity = fadeIn(frame, brandStart, 18);
  const taglineOpacity = fadeIn(frame, brandStart + 14, 16);

  return (
    <AbsoluteFill style={{ backgroundColor: tokens.color.background }}>
      {/* Phase 1 — final image */}
      {imageSrc && (
        <AbsoluteFill style={{ opacity: imageOpacity, overflow: 'hidden' }}>
          <Img
            src={staticFile(imageSrc)}
            style={{
              width: '100%',
              height: '100%',
              objectFit: 'cover',
              transform: `scale(${imageScale})`,
            }}
          />
        </AbsoluteFill>
      )}

      {/* Phase 2 — brand mark + tagline */}
      <AbsoluteFill
        style={{
          opacity: brandOpacity,
          display: 'flex',
          flexDirection: 'column',
          alignItems: 'center',
          justifyContent: 'center',
          padding: 96,
        }}
      >
        <Display size={120} color="ink" align="center">
          {typeof section.sceneProps.tagline === 'string'
            ? section.sceneProps.tagline
            : typeof section.sceneProps.projectName === 'string'
            ? section.sceneProps.projectName
            : ''}
        </Display>

        {section.vo && (
          <div style={{ marginTop: 32, opacity: taglineOpacity }}>
            <Caption uppercase color="accent" size={20} align="center">
              {/* Use the last short line of the VO as a sub-tagline if present */}
              {section.vo.split('.').slice(-2, -1).join('.').trim() || ''}
            </Caption>
          </div>
        )}
      </AbsoluteFill>
    </AbsoluteFill>
  );
};
