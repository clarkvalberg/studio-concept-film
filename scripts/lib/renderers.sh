#!/usr/bin/env bash

normalize_renderer() {
  case "${1:-}" in
    hyperframes | hyperframe | hf | HyperFrames)
      printf 'hyperframes\n'
      ;;
    remotion | Remotion)
      printf 'remotion\n'
      ;;
    *)
      printf 'Error: unsupported renderer "%s" (expected hyperframes or remotion)\n' "${1:-}" >&2
      return 1
      ;;
  esac
}

renderer_from_project() {
  local project_dir="$1"
  local requested="${2:-}"
  local renderer=""

  if [ -n "$requested" ]; then
    renderer="$requested"
  elif [ -n "${STUDIO_VIDEO_RENDERER:-}" ]; then
    renderer="$STUDIO_VIDEO_RENDERER"
  elif [ -n "${STUDIO_RENDERER:-}" ]; then
    renderer="$STUDIO_RENDERER"
  elif [ -f "$project_dir/renderer.json" ]; then
    renderer="$(awk -F'"' '/"renderer"[[:space:]]*:/ { print $4; exit }' "$project_dir/renderer.json")"
  elif [ -d "$project_dir/remotion" ] && [ ! -d "$project_dir/hyperframes" ]; then
    renderer="remotion"
  elif [ -d "$project_dir/hyperframes" ]; then
    renderer="hyperframes"
  else
    renderer="hyperframes"
  fi

  normalize_renderer "$renderer"
}

renderer_project_dir() {
  local project_dir="$1"
  local renderer="$2"

  case "$renderer" in
    hyperframes) printf '%s/hyperframes\n' "$project_dir" ;;
    remotion) printf '%s/remotion\n' "$project_dir" ;;
    *) normalize_renderer "$renderer" >/dev/null ;;
  esac
}

renderer_audio_dir() {
  local project_dir="$1"
  local renderer="$2"

  case "$renderer" in
    hyperframes) printf '%s/hyperframes/public/audio\n' "$project_dir" ;;
    remotion) printf '%s/remotion/public/audio\n' "$project_dir" ;;
    *) normalize_renderer "$renderer" >/dev/null ;;
  esac
}

renderer_template_dir() {
  local skill_dir="$1"
  local renderer="$2"

  case "$renderer" in
    hyperframes) printf '%s/assets/hyperframes-template\n' "$skill_dir" ;;
    remotion) printf '%s/assets/remotion-template\n' "$skill_dir" ;;
    *) normalize_renderer "$renderer" >/dev/null ;;
  esac
}

write_renderer_config() {
  local project_dir="$1"
  local renderer="$2"

  mkdir -p "$project_dir"
  cat > "$project_dir/renderer.json" << JSON
{
  "renderer": "$renderer",
  "supported_renderers": ["hyperframes", "remotion"],
  "default_renderer": "hyperframes"
}
JSON
}

ensure_node_package_deps() {
  local package_dir="$1"
  local label="$2"

  if [ ! -d "$package_dir/node_modules" ]; then
    echo "→ Installing $label dependencies"
    (
      cd "$package_dir" || exit
      if [ -f package-lock.json ]; then
        npm ci --silent
      else
        npm install --silent
      fi
    )
  fi
}
