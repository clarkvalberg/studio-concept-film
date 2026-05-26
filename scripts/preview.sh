#!/usr/bin/env bash
# preview.sh
#
# Launch the selected renderer's local preview server for a concept-film project.
#
# Usage:
#   scripts/preview.sh <project-directory>

set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <project-directory>" >&2
  exit 1
fi

PROJECT_DIR="$1"
SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=scripts/lib/renderers.sh
source "$SKILL_DIR/scripts/lib/renderers.sh"

RENDERER="$(renderer_from_project "$PROJECT_DIR")"
RENDERER_DIR="$(renderer_project_dir "$PROJECT_DIR" "$RENDERER")"

if [ ! -d "$RENDERER_DIR" ]; then
  echo "Error: $RENDERER project not found at $RENDERER_DIR" >&2
  echo "Run scripts/init-project.sh $PROJECT_DIR --renderer $RENDERER first." >&2
  exit 1
fi

if [ "$RENDERER" = "hyperframes" ]; then
  (
    cd "$RENDERER_DIR"
    STUDIO_RENDER_MODE=preview node scripts/generate-data.mjs
    npx --yes hyperframes@0.6.46 preview
  )
elif [ "$RENDERER" = "remotion" ]; then
  ensure_node_package_deps "$RENDERER_DIR" "Remotion"
  (
    cd "$RENDERER_DIR"
    npx --no-install remotion preview src/index.ts
  )
fi
