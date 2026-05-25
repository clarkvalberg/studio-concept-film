#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <video-file>" >&2
  exit 64
fi

video="$1"

if [[ ! -f "$video" ]]; then
  echo "Video not found: $video" >&2
  exit 66
fi

if ! command -v ffmpeg >/dev/null 2>&1; then
  echo "ffmpeg is required for static-video checks." >&2
  exit 69
fi

noise="${FREEZE_NOISE:-0.003}"
duration="${FREEZE_DURATION:-2}"
metadata_file="$(mktemp "${TMPDIR:-/tmp}/studio-video-freeze.XXXXXX")"
trap 'rm -f "$metadata_file"' EXIT

ffmpeg -hide_banner -nostats -i "$video" \
  -vf "freezedetect=n=${noise}:d=${duration},metadata=mode=print:file=${metadata_file}" \
  -an -f null - >/dev/null 2>&1

if grep -q 'lavfi.freezedetect.freeze_' "$metadata_file"; then
  echo "Likely static/freeze spans detected in $video"
  echo "Threshold: noise=${noise}, duration=${duration}s"
  awk -F= '/lavfi\.freezedetect\.freeze_/ { print "  " $1 "=" $2 }' "$metadata_file"
  exit 2
fi

echo "No freeze spans detected in $video at duration >= ${duration}s."
