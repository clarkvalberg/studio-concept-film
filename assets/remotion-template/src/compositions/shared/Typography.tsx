import React from 'react';
import { tokens } from './BrandTokens';

interface DisplayProps {
  children: React.ReactNode;
  size?: number;
  color?: keyof typeof tokens.color;
  style?: React.CSSProperties;
  align?: 'left' | 'center' | 'right';
}

export const Display: React.FC<DisplayProps> = ({ children, size = 96, color = 'ink', align = 'left', style = {} }) => (
  <div
    style={{
      fontFamily: `"${tokens.typography.display.family}", ${tokens.typography.display.fallback}`,
      fontWeight: tokens.typography.display.weight,
      fontSize: size,
      lineHeight: 1.05,
      letterSpacing: '-0.02em',
      color: tokens.color[color],
      textAlign: align,
      ...style,
    }}
  >
    {children}
  </div>
);

export const Body: React.FC<DisplayProps> = ({ children, size = 32, color = 'ink', align = 'left', style = {} }) => (
  <div
    style={{
      fontFamily: `"${tokens.typography.body.family}", ${tokens.typography.body.fallback}`,
      fontWeight: tokens.typography.body.weight,
      fontSize: size,
      lineHeight: 1.4,
      letterSpacing: '-0.005em',
      color: tokens.color[color],
      textAlign: align,
      ...style,
    }}
  >
    {children}
  </div>
);

interface CaptionProps extends DisplayProps {
  uppercase?: boolean;
}

export const Caption: React.FC<CaptionProps> = ({ children, size = 18, color = 'ink', align = 'left', uppercase = false, style = {} }) => (
  <div
    style={{
      fontFamily: `"${tokens.typography.mono.family}", ${tokens.typography.mono.fallback}`,
      fontWeight: tokens.typography.mono.weight,
      fontSize: size,
      lineHeight: 1.4,
      letterSpacing: uppercase ? '0.12em' : '0',
      textTransform: uppercase ? 'uppercase' : 'none',
      color: tokens.color[color],
      textAlign: align,
      ...style,
    }}
  >
    {children}
  </div>
);
