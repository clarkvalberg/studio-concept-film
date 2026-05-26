// BrandTokens.ts — Design tokens for this concept film.
//
// THIS IS THE PLACEHOLDER. The skill replaces this file with project-specific
// tokens during Phase 4 (design language). Do not edit by hand unless you're
// iterating on a rendered film.

export const tokens = {
  typography: {
    display: { family: 'GT Sectra Display', weight: 700, fallback: 'Georgia, serif' },
    body: { family: 'Inter', weight: 400, fallback: 'system-ui, sans-serif' },
    mono: { family: 'JetBrains Mono', weight: 400, fallback: 'ui-monospace, monospace' },
  },
  color: {
    background: '#F4EFE6',
    ink: '#1A1614',
    accent: '#2E6F5E',
    support: '#C9B89A',
  },
  motion: {
    entrance: 'cubic-bezier(0.16, 1, 0.3, 1)',
    exit: 'cubic-bezier(0.7, 0, 0.84, 0)',
    transition: 'cubic-bezier(0.4, 0, 0.2, 1)',
    durations: { fast: 200, medium: 400, slow: 700, hold: 1500 },
  },
  spacing: { unit: 8 },
} as const;

export type Tokens = typeof tokens;
