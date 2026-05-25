.DEFAULT_GOAL := help
.PHONY: help init audition voiceover voiceover-hook hook full preview lint typecheck shellcheck clean release-skill

# ──────────────────────────────────────────────────────────────────
#  studio-video-creator  ·  ergonomic command surface
#
#  Most targets take PROJECT=<dir> as an argument:
#      make hook PROJECT=~/concepts/harmony
#
#  Run `make help` for the full menu.
# ──────────────────────────────────────────────────────────────────

PROJECT ?=

help: ## Show this help
	@echo ""
	@echo "  studio-video-creator  ·  v1.0.0"
	@echo "  ────────────────────────────────────────────────────"
	@echo ""
	@echo "  Usage: make <target> [PROJECT=<path-to-project>]"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "    \033[36m%-18s\033[0m %s\n", $$1, $$2}'
	@echo ""
	@echo "  Examples"
	@echo "  ────────"
	@echo "    make init     PROJECT=~/concepts/harmony"
	@echo "    make hook     PROJECT=~/concepts/harmony"
	@echo "    make full     PROJECT=~/concepts/harmony"
	@echo ""

# ── project lifecycle ──────────────────────────────────────────────

init: _require-project ## Scaffold a new concept-film project
	@./scripts/init-project.sh $(PROJECT)

audition: ## Generate voice audition samples (use AUDITION_SCRIPT="text" AUDITION_OUT=dir VOICES="rachel,adam,antoni,lily")
	@./scripts/audition.sh \
		--script "$(AUDITION_SCRIPT)" \
		--voices "$(VOICES)" \
		--output "$(AUDITION_OUT)"

voiceover-hook: _require-project ## Generate hook voiceover (first ~15s) into <project>/remotion/public/audio/hook.mp3
	@./scripts/generate-voiceover.sh $(PROJECT) --hook-only

voiceover: _require-project ## Generate full voiceover into <project>/remotion/public/audio/voiceover.mp3
	@./scripts/generate-voiceover.sh $(PROJECT)

hook: _require-project ## Render the hook (~15s) — fast iteration unit
	@./scripts/render-hook.sh $(PROJECT)

full: _require-project ## Render the full film (60–90s)
	@./scripts/render-full.sh $(PROJECT)

preview: _require-project ## Launch Remotion preview at localhost:3000
	@cd $(PROJECT)/remotion && npx remotion studio

# ── repo maintenance ───────────────────────────────────────────────

lint: shellcheck typecheck ## Run all linters (shellcheck + tsc)

shellcheck: ## Run shellcheck on all bash scripts
	@echo "→ shellcheck scripts/"
	@shellcheck scripts/*.sh && echo "  ✓ all clean"

typecheck: ## Run TypeScript type-check on the Remotion template
	@echo "→ tsc --noEmit (Remotion template)"
	@cd assets/remotion-template && \
		(test -d node_modules || npm install --silent) && \
		npx tsc --noEmit && \
		echo "  ✓ all clean"

clean: ## Remove rendered output and caches (does not affect projects)
	@find . -name node_modules -type d -prune -exec rm -rf {} + 2>/dev/null || true
	@find . -name 'out' -type d -prune -exec rm -rf {} + 2>/dev/null || true
	@echo "  ✓ cleaned"

# ── release ────────────────────────────────────────────────────────

release-skill: ## Build studio-video-creator.skill from the current repo state
	@echo "→ packaging .skill file"
	@command -v zip >/dev/null 2>&1 || { echo "  ✗ zip not installed"; exit 1; }
	@rm -f studio-video-creator.skill
	@zip -rq studio-video-creator.skill . \
		-x '.git/*' \
		-x 'node_modules/*' \
		-x '**/node_modules/*' \
		-x '.DS_Store' \
		-x 'studio-video-creator.skill' \
		-x '*.mp4' \
		-x '*.mp3'
	@echo "  ✓ studio-video-creator.skill"

# ── internal ───────────────────────────────────────────────────────

_require-project:
	@if [ -z "$(PROJECT)" ]; then \
		echo ""; \
		echo "  ✗ PROJECT not set"; \
		echo ""; \
		echo "    Usage: make $(MAKECMDGOALS) PROJECT=<path>"; \
		echo "    Example: make $(MAKECMDGOALS) PROJECT=~/concepts/harmony"; \
		echo ""; \
		exit 1; \
	fi
