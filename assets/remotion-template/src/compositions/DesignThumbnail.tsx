import React from 'react';
import { AbsoluteFill } from 'remotion';
import { film } from '../data/film';
import { tokens } from './shared/BrandTokens';

const fontStack = (family: string, fallback: string) => `"${family}", ${fallback}`;

const shortLine = (value: string | undefined, fallback: string, max = 108): string => {
  const clean = (value ?? '').replace(/\s+/g, ' ').trim();
  if (!clean) return fallback;
  return clean.length > max ? `${clean.slice(0, max - 1).trim()}...` : clean;
};

const visionTagline = (): string => {
  const vision = film.sections.find((section) => section.id === 'vision-close');
  const tagline = vision?.sceneProps.tagline;
  return typeof tagline === 'string' && tagline.trim()
    ? tagline.trim()
    : 'A concept film style frame.';
};

const PaletteSwatch: React.FC<{ label: string; value: string }> = ({ label, value }) => (
  <div style={{ display: 'flex', alignItems: 'center', gap: 14 }}>
    <div
      style={{
        width: 36,
        height: 36,
        borderRadius: 18,
        backgroundColor: value,
        border: `1px solid ${tokens.color.ink}22`,
      }}
    />
    <div>
      <div
        style={{
          fontFamily: fontStack(tokens.typography.mono.family, tokens.typography.mono.fallback),
          fontSize: 15,
          lineHeight: 1.1,
          color: tokens.color.ink,
          opacity: 0.62,
          textTransform: 'uppercase',
          letterSpacing: '0.08em',
        }}
      >
        {label}
      </div>
      <div
        style={{
          marginTop: 4,
          fontFamily: fontStack(tokens.typography.mono.family, tokens.typography.mono.fallback),
          fontSize: 18,
          color: tokens.color.ink,
        }}
      >
        {value}
      </div>
    </div>
  </div>
);

const MiniInterface: React.FC = () => (
  <div
    style={{
      width: 560,
      height: 380,
      borderRadius: 28,
      background: `linear-gradient(145deg, ${tokens.color.ink}10, ${tokens.color.support}24)`,
      border: `1px solid ${tokens.color.ink}18`,
      boxShadow: `0 32px 90px ${tokens.color.ink}24`,
      padding: 28,
      display: 'grid',
      gridTemplateColumns: '128px 1fr',
      gap: 24,
    }}
  >
    <div
      style={{
        borderRadius: 18,
        backgroundColor: tokens.color.ink,
        padding: 18,
        display: 'flex',
        flexDirection: 'column',
        gap: 14,
      }}
    >
      {[0, 1, 2, 3].map((item) => (
        <div
          key={item}
          style={{
            height: item === 0 ? 42 : 30,
            borderRadius: 999,
            backgroundColor: item === 0 ? tokens.color.accent : `${tokens.color.background}28`,
          }}
        />
      ))}
    </div>
    <div style={{ display: 'flex', flexDirection: 'column', gap: 22 }}>
      <div
        style={{
          height: 154,
          borderRadius: 22,
          backgroundColor: tokens.color.background,
          border: `1px solid ${tokens.color.ink}14`,
          padding: 24,
        }}
      >
        <div style={{ width: 180, height: 16, borderRadius: 8, backgroundColor: tokens.color.accent }} />
        <div style={{ marginTop: 44, width: '92%', height: 20, borderRadius: 10, backgroundColor: `${tokens.color.ink}2E` }} />
        <div style={{ marginTop: 14, width: '62%', height: 20, borderRadius: 10, backgroundColor: `${tokens.color.ink}1C` }} />
      </div>
      <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 18 }}>
        {[tokens.color.support, tokens.color.accent].map((color, index) => (
          <div
            key={color}
            style={{
              height: 128,
              borderRadius: 20,
              backgroundColor: index === 0 ? `${color}4D` : color,
              border: `1px solid ${tokens.color.ink}12`,
            }}
          />
        ))}
      </div>
    </div>
  </div>
);

export const DesignThumbnail: React.FC = () => {
  const projectName = shortLine(film.meta.projectName, 'Project Name', 48);
  const variantLabel = film.meta.variant.replace('-', ' ');
  const sampleLine = shortLine(
    film.sections.find((section) => section.id === 'insight')?.vo ?? film.sections[0]?.vo,
    'Representative title-card language goes here.',
    118
  );
  const tagline = shortLine(visionTagline(), 'Concept film style frame.', 72);

  return (
    <AbsoluteFill
      style={{
        backgroundColor: tokens.color.background,
        color: tokens.color.ink,
        overflow: 'hidden',
      }}
    >
      <div
        style={{
          position: 'absolute',
          inset: 0,
          background: `radial-gradient(circle at 78% 22%, ${tokens.color.accent}2E 0, transparent 30%), linear-gradient(120deg, transparent 0%, ${tokens.color.support}18 72%, transparent 100%)`,
        }}
      />
      <div
        style={{
          position: 'absolute',
          left: 86,
          top: 76,
          right: 86,
          bottom: 76,
          display: 'grid',
          gridTemplateColumns: '1fr 620px',
          gap: 86,
          alignItems: 'center',
        }}
      >
        <div>
          <div
            style={{
              fontFamily: fontStack(tokens.typography.mono.family, tokens.typography.mono.fallback),
              fontSize: 22,
              color: tokens.color.accent,
              textTransform: 'uppercase',
              letterSpacing: '0.12em',
            }}
          >
            Style frame / {variantLabel}
          </div>
          <div
            style={{
              marginTop: 48,
              fontFamily: fontStack(tokens.typography.display.family, tokens.typography.display.fallback),
              fontWeight: tokens.typography.display.weight,
              fontSize: 126,
              lineHeight: 0.96,
              color: tokens.color.ink,
              maxWidth: 790,
              overflowWrap: 'break-word',
            }}
          >
            {projectName}
          </div>
          <div style={{ width: 132, height: 8, backgroundColor: tokens.color.accent, marginTop: 42 }} />
          <div
            style={{
              marginTop: 34,
              maxWidth: 760,
              fontFamily: fontStack(tokens.typography.body.family, tokens.typography.body.fallback),
              fontWeight: tokens.typography.body.weight,
              fontSize: 38,
              lineHeight: 1.24,
              color: tokens.color.ink,
              opacity: 0.84,
            }}
          >
            {sampleLine}
          </div>
          <div
            style={{
              marginTop: 38,
              fontFamily: fontStack(tokens.typography.mono.family, tokens.typography.mono.fallback),
              fontSize: 19,
              lineHeight: 1.45,
              color: tokens.color.ink,
              opacity: 0.62,
              maxWidth: 700,
            }}
          >
            {tagline}
          </div>
        </div>

        <div style={{ display: 'flex', flexDirection: 'column', gap: 34 }}>
          <MiniInterface />
          <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 22 }}>
            <PaletteSwatch label="Background" value={tokens.color.background} />
            <PaletteSwatch label="Ink" value={tokens.color.ink} />
            <PaletteSwatch label="Accent" value={tokens.color.accent} />
            <PaletteSwatch label="Support" value={tokens.color.support} />
          </div>
        </div>
      </div>
    </AbsoluteFill>
  );
};
