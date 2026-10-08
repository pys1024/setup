#!/usr/bin/env bash
set -euo pipefail

read_clipboard() {
  if command -v pbpaste >/dev/null 2>&1; then
    pbpaste
  elif command -v wl-paste >/dev/null 2>&1; then
    wl-paste --no-newline || wl-paste
  elif command -v xclip >/dev/null 2>&1; then
    xclip -selection clipboard -o
  elif command -v xsel >/dev/null 2>&1; then
    xsel -o --clipboard
  elif command -v powershell.exe >/dev/null 2>&1; then
    powershell.exe -NoProfile -Command Get-Clipboard
  else
    return 1
  fi
}

# Stream the clipboard straight into a file (normalizing CRLF -> LF). This
# avoids holding the whole selection in a shell variable and feeding it to
# `set-buffer -- "$content"`, which is capped by tmux's ~16KB command limit
# and the OS per-argument limit (MAX_ARG_STRLEN, 128KB).
tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT
if ! read_clipboard | tr -d '\r' > "$tmp"; then
  exit 0
fi
[[ -s "$tmp" ]] || exit 0

# One tmux client round-trip: load from file, then paste it.
tmux load-buffer "$tmp" \; paste-buffer -p -d

