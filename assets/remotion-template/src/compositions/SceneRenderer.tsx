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

export const SceneRenderer: React.FC<SceneRendererProps> = ({ section }) => {
  const Scene = sceneRegistry[section.sceneType];
  if (!Scene) {
    console.warn(`Unknown sceneType: ${section.sceneType}. Falling back to InsightCard.`);
    return <InsightCard section={section} />;
  }
  return <Scene section={section} />;
};
