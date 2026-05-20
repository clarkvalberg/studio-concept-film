import React from 'react';
import { AbsoluteFill, Img, staticFile, useCurrentFrame, useVideoConfig, interpolate } from 'remotion';
import type { Section } from '../../types';
import { tokens } from '../shared/BrandTokens';
import { Caption } from '../shared/Typography';
import { fadeInHoldOut, fadeIn } from '../shared/motion';

interface Props { section: Section; }

/**
 * ScreenCallout — single product screen with annotated callouts.
 * Callouts appear sequentially, each fading in with a connecting line.
 * Use when the product walk needs to name specific UI elements.
 */
export const ScreenCallout: React.FC<Props> = ({ section }) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();
  const totalFrames = Math.round(section.duration * fps);
  const opacity = fadeInHoldOut(frame, totalFrames, 16);

  const screen = section.sceneProps.screen
    ?? (typeof section.sceneProps.screens?.[0] === 'string'
      ? (section.sceneProps.screens?.[0] as string)
      : (section.sceneProps.screens?.[0] as { src?: string } | undefined)?.src);

  const callouts = section.sceneProps.callouts ?? [];

  // Stagger callouts: first appears at 25%, last by 75%
  const calloutStart = Math.round(totalFrames * 0.25);
  const calloutSpan = Math.round(totalFrames * 0.5);
  const perCalloutOffset = callouts.length > 0 ? calloutSpan / callouts.length : 0;

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
      <div style={{ position: 'relative', maxWidth: '78%', maxHeight: '82%' }}>
        {screen ? (
          <Img
            src={staticFile(screen)}
            style={{
              width: '100%',
              height: 'auto',
              display: 'block',
              borderRadius: 14,
              boxShadow: '0 30px 60px rgba(0,0,0,0.18), 0 8px 16px rgba(0,0,0,0.08)',
            }}
          />
        ) : (
          <div
            style={{
              width: 1200,
              height: 720,
              border: `2px dashed ${tokens.color.support}`,
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              color: tokens.color.support,
              fontFamily: 'monospace',
            }}
          >
            [screen — set sceneProps.screen]
          </div>
        )}

        {/* Callouts overlaid */}
        {callouts.map((callout, i) => {
          const startFrame = calloutStart + i * perCalloutOffset;
          const calloutOpacity = fadeIn(frame, startFrame, 12);
          return (
            <div
              key={i}
              style={{
                position: 'absolute',
                left: `${callout.x}%`,
                top: `${callout.y}%`,
                opacity: calloutOpacity,
                pointerEvents: 'none',
              }}
            >
              <div
                style={{
                  width: 14,
                  height: 14,
                  borderRadius: '50%',
                  background: tokens.color.accent,
                  boxShadow: `0 0 0 6px ${tokens.color.accent}33`,
                }}
              />
              <div
                style={{
                  position: 'absolute',
                  left: 28,
                  top: -4,
                  whiteSpace: 'nowrap',
                  background: tokens.color.ink,
                  color: tokens.color.background,
                  padding: '8px 14px',
                  borderRadius: 6,
                }}
              >
                <Caption size={16} color="background" style={{ color: tokens.color.background }}>
                  {callout.label}
                </Caption>
              </div>
            </div>
          );
        })}
      </div>
    </AbsoluteFill>
  );
};
