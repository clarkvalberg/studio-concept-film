#!/usr/bin/env bash
# measure-audio.sh — Measure the duration of an audio file (seconds, 2 decimals).
# Used by the skill to align section timing with actual TTS output length.
#
# Usage: ./measure-audio.sh <audio-file>

set -euo pipefail

[[ $# -lt 1 ]] && { echo "Usage: $0 <audio-file>" >&2; exit 1; }

if ! command -v ffprobe >/dev/null 2>&1; then
  echo "Error: ffprobe not found. Install ffmpeg (brew install ffmpeg)." >&2
  exit 1
fi

ffprobe -v error -show_entries format=duration -of csv=p=0 "$1" | awk '{printf "%.2f\n", $1}'
