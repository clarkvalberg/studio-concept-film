import React from 'react';
import { Composition } from 'remotion';
import { film } from './data/film';
import { HookFilm } from './compositions/HookFilm';
import { FullFilm } from './compositions/FullFilm';

const HOOK_SECONDS = 15;

export const Root: React.FC = () => {
  const { fps, width, height, totalDuration } = film.meta;

  // Hook duration is min of 15s or the actual first-two-sections duration
  const firstTwoSectionsDuration = film.sections.slice(0, 2).reduce((sum, s) => sum + s.duration, 0);
  const hookDuration = Math.min(HOOK_SECONDS, firstTwoSectionsDuration);

  return (
    <>
      <Composition
        id="Hook"
        component={HookFilm}
        durationInFrames={Math.round(hookDuration * fps)}
        fps={fps}
        width={width}
        height={height}
      />
      <Composition
        id="Full"
        component={FullFilm}
        durationInFrames={Math.round(totalDuration * fps)}
        fps={fps}
        width={width}
        height={height}
      />
    </>
  );
};
