#!/usr/bin/env bash
# audition.sh — Generate ElevenLabs voice audition samples for a script.
#
# Usage:
#   ./audition.sh --script "Cold open text…" \
#                 --voices "Rachel,Brian,Charlotte,Antoni" \
#                 --output ./voice-auditions/
#
# Requires: ELEVENLABS_API_KEY env var, curl, jq.
#
# Voice names map to IDs from references/voice-shortlist.md. Custom IDs
# can also be passed (any 20-char hex string is treated as a voice_id).
#
# Output: <output-dir>/<voice-name>.mp3 for each voice, plus an index.html
# that plays them inline for the user.

set -euo pipefail

SCRIPT_TEXT=""
VOICES=""
OUTPUT_DIR=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --script) SCRIPT_TEXT="$2"; shift 2 ;;
    --voices) VOICES="$2"; shift 2 ;;
    --output) OUTPUT_DIR="$2"; shift 2 ;;
    -h|--help)
      grep '^# ' "$0" | sed 's/^# //'
      exit 0
      ;;
    *)
      echo "Unknown arg: $1" >&2
      exit 1
      ;;
  esac
done

[[ -z "$SCRIPT_TEXT" || -z "$VOICES" || -z "$OUTPUT_DIR" ]] && {
  echo "Usage: $0 --script TEXT --voices NAME[,NAME...] --output DIR" >&2
  exit 1
}

[[ -z "${ELEVENLABS_API_KEY:-}" ]] && {
  echo "Error: ELEVENLABS_API_KEY not set." >&2
  echo "Get a key at https://elevenlabs.io/app/settings/api-keys" >&2
  exit 1
}

# Voice name → ID map (matches references/voice-shortlist.md)
declare -A VOICE_MAP=(
  ["Rachel"]="21m00Tcm4TlvDq8ikWAM"
  ["Brian"]="nPczCjzI2devNBz1zQrb"
  ["Adam"]="pNInz6obpgDQGcFmaJgB"
  ["Charlotte"]="XB0fDUnXU5powFXDhCwa"
  ["Daniel"]="onwK4e9ZLuTAKqWW03F9"
  ["Antoni"]="ErXwobaYiN019PkySvjV"
  ["Lily"]="pFZP5JQG7iQjIQuC4Bku"
  ["Will"]="bIHbv24MWmeRgasZH58o"
)

mkdir -p "$OUTPUT_DIR"

# Per-voice settings (default; refined in references/voice-shortlist.md)
SETTINGS_JSON='{"stability":0.5,"similarity_boost":0.75,"style":0.3,"use_speaker_boost":true}'

IFS=',' read -ra VOICE_ARR <<< "$VOICES"

# Generate the index.html header
cat > "$OUTPUT_DIR/index.html" << 'HEAD'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Voice Auditions</title>
<style>
  :root {
    --bg: #FAFAF7;
    --ink: #1A1614;
    --accent: #2E6F5E;
    --muted: #7A746F;
  }
  body {
    background: var(--bg);
    color: var(--ink);
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, sans-serif;
    margin: 0;
    padding: 48px 32px;
    max-width: 720px;
    margin: 0 auto;
  }
  h1 { font-weight: 600; font-size: 24px; margin-bottom: 8px; }
  .lede { color: var(--muted); margin-bottom: 40px; }
  .script {
    background: white;
    padding: 24px;
    border-radius: 4px;
    font-size: 18px;
    line-height: 1.5;
    margin-bottom: 40px;
    border-left: 3px solid var(--accent);
  }
  .voice {
    padding: 20px 0;
    border-bottom: 1px solid #E5E2DC;
  }
  .voice:last-child { border-bottom: none; }
  .voice h2 { font-size: 18px; margin: 0 0 12px 0; font-weight: 600; }
  audio { width: 100%; }
  .footer { margin-top: 48px; color: var(--muted); font-size: 14px; }
</style>
</head>
<body>
<h1>Voice Auditions</h1>
<p class="lede">Four voices reading the same opening. Pick one, or ask for more options.</p>
<div class="script">
HEAD

# Add the script
printf '%s\n' "$SCRIPT_TEXT" >> "$OUTPUT_DIR/index.html"
echo "</div>" >> "$OUTPUT_DIR/index.html"

for voice in "${VOICE_ARR[@]}"; do
  voice="$(echo "$voice" | xargs)"  # trim whitespace

  # Resolve voice_id
  if [[ -n "${VOICE_MAP[$voice]:-}" ]]; then
    voice_id="${VOICE_MAP[$voice]}"
    voice_label="$voice"
  elif [[ "$voice" =~ ^[a-zA-Z0-9]{20}$ ]]; then
    voice_id="$voice"
    voice_label="custom-${voice:0:8}"
  else
    echo "Unknown voice: $voice (skipping)" >&2
    continue
  fi

  echo "→ Generating sample: $voice_label ($voice_id)"

  output_file="$OUTPUT_DIR/${voice_label}.mp3"

  payload=$(jq -n \
    --arg text "$SCRIPT_TEXT" \
    --argjson settings "$SETTINGS_JSON" \
    '{
      text: $text,
      model_id: "eleven_multilingual_v2",
      voice_settings: $settings
    }')

  http_code=$(curl -s -w "%{http_code}" -o "$output_file" \
    -X POST "https://api.elevenlabs.io/v1/text-to-speech/${voice_id}" \
    -H "xi-api-key: $ELEVENLABS_API_KEY" \
    -H "Content-Type: application/json" \
    -d "$payload")

  if [[ "$http_code" != "200" ]]; then
    echo "  ✗ Failed (HTTP $http_code)" >&2
    cat "$output_file" >&2 2>/dev/null || true
    rm -f "$output_file"
    continue
  fi

  echo "  ✓ Saved $(du -h "$output_file" | cut -f1)"

  # Append to index.html
  cat >> "$OUTPUT_DIR/index.html" << VOICE_BLOCK
<div class="voice">
  <h2>${voice_label}</h2>
  <audio controls preload="metadata" src="${voice_label}.mp3"></audio>
</div>
VOICE_BLOCK
done

cat >> "$OUTPUT_DIR/index.html" << 'FOOT'
<div class="footer">Generated via ElevenLabs API. Read references/voice-shortlist.md for fit notes per voice.</div>
</body>
</html>
FOOT

echo ""
echo "✓ Auditions complete: $OUTPUT_DIR/"
echo "  Open: $OUTPUT_DIR/index.html"
