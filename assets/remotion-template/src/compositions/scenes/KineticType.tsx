import React from 'react';
import { AbsoluteFill, useCurrentFrame, useVideoConfig, interpolate } from 'remotion';
import type { Section } from '../../types';
import { tokens } from '../shared/BrandTokens';
import { Display } from '../shared/Typography';
import { fadeInHoldOut } from '../shared/motion';

interface Props { section: Section; }

/**
 * KineticType — pure typographic moment, no imagery.
 * The phrase fills the frame; words can stagger in word-by-word.
 * Use for insight punchlines, transitional statements, and stat reveals.
 */
export const KineticType: React.FC<Props> = ({ section }) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();
  const totalFrames = Math.round(section.duration * fps);
  const opacity = fadeInHoldOut(frame, totalFrames, 14);

  const phrase = section.sceneProps.phrase ?? section.sceneProps.kineticPhrase ?? section.vo;
  const words = phrase.split(/\s+/).filter(Boolean);

  // Words stagger in over first 40% of the section
  const staggerFrames = Math.round(totalFrames * 0.4);
  const perWordOffset = staggerFrames / Math.max(words.length, 1);

  const bg = section.sceneProps.background === 'ink' ? tokens.color.ink : tokens.color.background;
  const fg = section.sceneProps.background === 'ink' ? 'background' : 'ink';

  return (
    <AbsoluteFill
      style={{
        backgroundColor: bg,
        opacity,
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        padding: 96,
      }}
    >
      <Display size={120} color={fg as 'ink' | 'background' | 'accent' | 'support'} align="center">
        {words.map((word, i) => {
          const wordStart = i * perWordOffset;
          const wordOpacity = interpolate(
            frame,
            [wordStart, wordStart + 12],
            [0, 1],
            { extrapolateLeft: 'clamp', extrapolateRight: 'clamp' }
          );
          const wordY = interpolate(
            frame,
            [wordStart, wordStart + 12],
            [16, 0],
            { extrapolateLeft: 'clamp', extrapolateRight: 'clamp' }
          );
          return (
            <span
              key={i}
              style={{
                display: 'inline-block',
                opacity: wordOpacity,
                transform: `translateY(${wordY}px)`,
                marginRight: '0.25em',
              }}
            >
              {word}
            </span>
          );
        })}
      </Display>
    </AbsoluteFill>
  );
};
