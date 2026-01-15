#!/bin/bash

direction="$1"

if [ -z "$direction" ]; then
  exit 0
fi

python3 "$HOME/.setup/tmux/scripts/session_manager.py" move "$direction"
