import React from 'react';
import { AbsoluteFill, useCurrentFrame, useVideoConfig } from 'remotion';
import type { Section } from '../../types';
import { tokens } from '../shared/BrandTokens';
import { Display } from '../shared/Typography';
import { fadeInHoldOut, useSpringEntrance } from '../shared/motion';

interface Props { section: Section; }

/**
 * InsightCard — the typographic moment that lands the conceptual shift.
 * Mostly negative space, single phrase or fragment, often with a kinetic
 * emphasis on one word or phrase.
 */
export const InsightCard: React.FC<Props> = ({ section }) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();
  const totalFrames = Math.round(section.duration * fps);
  const opacity = fadeInHoldOut(frame, totalFrames, 18);

  const phrase = section.sceneProps.kineticPhrase ?? section.sceneProps.phrase;
  const spring = useSpringEntrance(8);

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
      <div style={{ maxWidth: '70%' }}>
        <Display size={96} color={fg as 'ink' | 'background' | 'accent' | 'support'} align="center">
          {section.vo.split(/(\s+)/).map((word, i) => {
            const isHighlight = phrase && word.toLowerCase().includes(phrase.toLowerCase().split(' ')[0] ?? '');
            return (
              <span
                key={i}
                style={{
                  color: isHighlight ? tokens.color.accent : undefined,
                  transform: isHighlight ? `scale(${0.95 + 0.05 * spring})` : undefined,
                  display: isHighlight ? 'inline-block' : 'inline',
                }}
              >
                {word}
              </span>
            );
          })}
        </Display>
      </div>
    </AbsoluteFill>
  );
};
