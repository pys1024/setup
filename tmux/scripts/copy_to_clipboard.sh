#!/usr/bin/env bash
set -euo pipefail

# Buffer stdin once so it can feed both tmux and the system clipboard.
tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT
cat | tr -d '\r' > "$tmp"

# Update tmux buffer. load-buffer reads from a file/stdin, so unlike
# `set-buffer -- "$content"` it is not limited by tmux's ~16KB command
# length limit nor by the OS per-argument limit (MAX_ARG_STRLEN, 128KB).
tmux load-buffer "$tmp" 2>/dev/null || true

# Best-effort: also call platform clip utilities when available
if command -v pbcopy >/dev/null 2>&1; then
  pbcopy < "$tmp" || true
elif command -v wl-copy >/dev/null 2>&1; then
  wl-copy --type text < "$tmp" || wl-copy < "$tmp" || true
elif command -v xclip >/dev/null 2>&1; then
  xclip -selection clipboard < "$tmp" || true
elif command -v xsel >/dev/null 2>&1; then
  xsel --clipboard --input < "$tmp" || true
elif command -v powershell.exe >/dev/null 2>&1; then
  powershell.exe -NoProfile -Command "Set-Clipboard -Value ([Console]::In.ReadToEnd())" < "$tmp" || true
fi

