#!/usr/bin/env bash
# generate-voiceover.sh — Generate the full voiceover audio for a project's script.
#
# Reads voice.json for the voice_id and settings, reads script.md for the text,
# outputs to hyperframes/public/audio/voiceover.mp3.
#
# Usage: ./generate-voiceover.sh <project-dir> [--hook-only]

set -euo pipefail

[[ $# -lt 1 ]] && { echo "Usage: $0 <project-dir> [--hook-only]" >&2; exit 1; }

PROJECT_DIR="$1"
HOOK_ONLY=false
[[ "${2:-}" == "--hook-only" ]] && HOOK_ONLY=true

[[ -z "${ELEVENLABS_API_KEY:-}" ]] && {
  echo "Error: ELEVENLABS_API_KEY not set." >&2
  exit 1
}

VOICE_JSON="$PROJECT_DIR/voice.json"
SCRIPT_MD="$PROJECT_DIR/script.md"

[[ ! -f "$VOICE_JSON" ]] && { echo "Error: $VOICE_JSON not found." >&2; exit 1; }
[[ ! -f "$SCRIPT_MD" ]] && { echo "Error: $SCRIPT_MD not found." >&2; exit 1; }

voice_id=$(jq -r '.voice_id' "$VOICE_JSON")
[[ "$voice_id" == "null" || -z "$voice_id" ]] && {
  echo "Error: voice_id not set in $VOICE_JSON. Complete Phase 5 first." >&2
  exit 1
}

settings=$(jq -c '.settings // {stability:0.5,similarity_boost:0.75,style:0.3,use_speaker_boost:true}' "$VOICE_JSON")
model=$(jq -r '.model // "eleven_multilingual_v2"' "$VOICE_JSON")

# Extract VO lines from script.md
# (lines starting with **VO:** — strip the prefix, join with spaces)
extract_vo() {
  local input="$1"
  awk '/^\*\*VO:\*\*/ { sub(/^\*\*VO:\*\* */, ""); print }' "$input" | tr '\n' ' '
}

if $HOOK_ONLY; then
  # Extract VO up through the first section's VO only (typically Cold Open)
  vo_text=$(awk '
    /^## / { section_count++ }
    section_count <= 1 && /^\*\*VO:\*\*/ { sub(/^\*\*VO:\*\* */, ""); print }
  ' "$SCRIPT_MD" | tr '\n' ' ')
  out_file="$PROJECT_DIR/hyperframes/public/audio/hook.mp3"
else
  vo_text=$(extract_vo "$SCRIPT_MD")
  out_file="$PROJECT_DIR/hyperframes/public/audio/voiceover.mp3"
fi

vo_text=$(printf '%s' "$vo_text" | sed 's/  */ /g; s/^ *//; s/ *$//')

[[ -z "$vo_text" ]] && {
  echo "Error: No VO lines found in $SCRIPT_MD. Expected lines starting with **VO:**" >&2
  exit 1
}

echo "Generating voiceover ($(echo "$vo_text" | wc -w | xargs) words) → $out_file"

mkdir -p "$(dirname "$out_file")"

payload=$(jq -n \
  --arg text "$vo_text" \
  --arg model "$model" \
  --argjson settings "$settings" \
  '{text: $text, model_id: $model, voice_settings: $settings}')

http_code=$(curl -s -w "%{http_code}" -o "$out_file" \
  -X POST "https://api.elevenlabs.io/v1/text-to-speech/${voice_id}" \
  -H "xi-api-key: $ELEVENLABS_API_KEY" \
  -H "Content-Type: application/json" \
  -d "$payload")

if [[ "$http_code" != "200" ]]; then
  echo "✗ Failed (HTTP $http_code)" >&2
  exit 1
fi

echo "✓ Generated $(du -h "$out_file" | cut -f1)"
if command -v ffprobe >/dev/null 2>&1; then
  duration=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$out_file" | awk '{printf "%.1f", $1}')
  echo "  Duration: ${duration}s"
fi
