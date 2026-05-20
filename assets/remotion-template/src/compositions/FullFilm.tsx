import React from 'react';
import { AbsoluteFill, Audio, Sequence, useVideoConfig, staticFile } from 'remotion';
import { film } from '../data/film';
import { tokens } from './shared/BrandTokens';
import { SceneRenderer } from './SceneRenderer';

export const FullFilm: React.FC = () => {
  const { fps } = useVideoConfig();

  return (
    <AbsoluteFill style={{ backgroundColor: tokens.color.background }}>
      {film.sections.map((section) => {
        const fromFrame = Math.round(section.start * fps);
        const durationInFrames = Math.round(section.duration * fps);
        return (
          <Sequence key={section.id} from={fromFrame} durationInFrames={durationInFrames}>
            <SceneRenderer section={section} />
          </Sequence>
        );
      })}

      {film.voice.voiceId && (
        <Audio src={staticFile(film.voice.fullAudio)} />
      )}
    </AbsoluteFill>
  );
};
