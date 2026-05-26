import React from 'react';
import type { Section } from '../types';
import { CustomerMoment } from './scenes/CustomerMoment';
import { InsightCard } from './scenes/InsightCard';
import { ProblemFrame } from './scenes/ProblemFrame';
import { ProductWalk } from './scenes/ProductWalk';
import { ProductFrame } from './scenes/ProductFrame';
import { VisionClose } from './scenes/VisionClose';
import { KineticType } from './scenes/KineticType';
import { ScreenCallout } from './scenes/ScreenCallout';
import { MotionFloor } from './shared/MotionFloor';

const sceneRegistry = {
  CustomerMoment,
  InsightCard,
  ProblemFrame,
  ProductWalk,
  ProductFrame,
  VisionClose,
  KineticType,
  ScreenCallout,
} as const;

interface SceneRendererProps {
  section: Section;
}

const needsStrongMotionFloor = (section: Section): boolean => {
  const screens = section.sceneProps.screens;
  return (
    section.sceneProps.imagery === 'placeholder' ||
    section.sceneProps.finalImage === 'placeholder' ||
    (Array.isArray(screens) && screens.length === 0) ||
    section.sceneType === 'InsightCard' ||
    section.sceneType === 'KineticType'
  );
};

export const SceneRenderer: React.FC<SceneRendererProps> = ({ section }) => {
  const Scene = sceneRegistry[section.sceneType];
  const floorIntensity = needsStrongMotionFloor(section) ? 'strong' : 'subtle';
  if (!Scene) {
    console.warn(`Unknown sceneType: ${section.sceneType}. Falling back to InsightCard.`);
    return (
      <>
        <InsightCard section={section} />
        <MotionFloor durationSeconds={section.duration} intensity={floorIntensity} />
      </>
    );
  }
  return (
    <>
      <Scene section={section} />
      <MotionFloor durationSeconds={section.duration} intensity={floorIntensity} />
    </>
  );
};
