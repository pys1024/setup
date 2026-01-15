#!/bin/bash

index="$1"

if [[ -z "$index" || ! "$index" =~ ^[0-9]+$ ]]; then
  exit 0
fi

python3 "$HOME/.setup/tmux/scripts/session_manager.py" move-window-to "$index"
