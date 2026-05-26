.DEFAULT_GOAL := help
.PHONY: help init audition design-thumbnail voiceover voiceover-hook hook full preview lint template-check typecheck shellcheck clean release-skill

# ──────────────────────────────────────────────────────────────────
#  studio-video-creator  ·  ergonomic command surface
#
#  Most targets take PROJECT=<dir> as an argument:
#      make hook PROJECT=~/concepts/signatures-law
#
#  Run `make help` for the full menu.
# ──────────────────────────────────────────────────────────────────

PROJECT ?=

help: ## Show this help
	@echo ""
	@echo "  studio-video-creator  ·  v1.1.0"
	@echo "  ────────────────────────────────────────────────────"
	@echo ""
	@echo "  Usage: make <target> [PROJECT=<path-to-project>]"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "    \033[36m%-18s\033[0m %s\n", $$1, $$2}'
	@echo ""
	@echo "  Examples"
	@echo "  ────────"
	@echo "    make init     PROJECT=~/concepts/signatures-law"
	@echo "    make hook     PROJECT=~/concepts/signatures-law"
	@echo "    make full     PROJECT=~/concepts/signatures-law"
	@echo ""

# ── project lifecycle ──────────────────────────────────────────────

init: _require-project ## Scaffold a new concept-film project
	@./scripts/init-project.sh $(PROJECT)

audition: ## Generate voice audition samples (use AUDITION_SCRIPT="text" AUDITION_OUT=dir VOICES="rachel,adam,antoni,lily")
	@./scripts/audition.sh \
		--script "$(AUDITION_SCRIPT)" \
		--voices "$(VOICES)" \
		--output "$(AUDITION_OUT)"

design-thumbnail: _require-project ## Render the Phase 4 design thumbnail to <project>/out/design-thumbnail.png
	@./scripts/render-design-thumbnail.sh $(PROJECT)

voiceover-hook: _require-project ## Generate hook voiceover (first ~15s) into <project>/hyperframes/public/audio/hook.mp3
	@./scripts/generate-voiceover.sh $(PROJECT) --hook-only

voiceover: _require-project ## Generate full voiceover into <project>/hyperframes/public/audio/voiceover.mp3
	@./scripts/generate-voiceover.sh $(PROJECT)

hook: _require-project ## Render the hook (~15s) and export cover-frame.png
	@./scripts/render-hook.sh $(PROJECT)

full: _require-project ## Render the full film (60–90s)
	@./scripts/render-full.sh $(PROJECT)

preview: _require-project ## Launch HyperFrames preview at localhost:3002
	@cd $(PROJECT)/hyperframes && STUDIO_RENDER_MODE=preview node scripts/generate-data.mjs && npx --yes hyperframes@0.6.46 preview

# ── repo maintenance ───────────────────────────────────────────────

lint: shellcheck template-check ## Run all linters (shellcheck + HyperFrames lint)

shellcheck: ## Run shellcheck on all bash scripts
	@echo "→ shellcheck scripts/"
	@shellcheck scripts/*.sh && echo "  ✓ all clean"

template-check: ## Run HyperFrames template checks
	@echo "→ hyperframes lint (template)"
	@cd assets/hyperframes-template && \
		node scripts/generate-data.mjs && \
		npx --yes hyperframes@0.6.46 lint && \
		echo "  ✓ all clean"

typecheck: template-check ## Compatibility alias for older scripts

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
	@zip -rq studio-video-creator.skill docs/media/signatures-law-final-2026-05-25.mp4
	@echo "  ✓ studio-video-creator.skill"

# ── internal ───────────────────────────────────────────────────────

_require-project:
	@if [ -z "$(PROJECT)" ]; then \
		echo ""; \
		echo "  ✗ PROJECT not set"; \
		echo ""; \
		echo "    Usage: make $(MAKECMDGOALS) PROJECT=<path>"; \
		echo "    Example: make $(MAKECMDGOALS) PROJECT=~/concepts/signatures-law"; \
		echo ""; \
		exit 1; \
	fi
