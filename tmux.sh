#!/usr/bin/env bash

if tmux has-session -t pys1024 &> /dev/null; then
    tmux a -t pys1024
    exit
fi

cd
tmux new-session -d -s pys1024
tmux rename-window Home
tmux split-window -h
tmux select-pane -t 1
tmux split-window -v
tmux select-pane -t 1
tmux send-keys "htop" C-m
tmux select-pane -t 2
# tmux send-keys "cd clashy && ./Clashy*; ./run.sh" C-m
tmux select-pane -t 3

tmux new-window
tmux rename-window Code
tmux split-window -h
tmux select-pane -t 1
tmux split-window -v
tmux select-pane -t 3

tmux new-window
tmux rename-window Debug
tmux split-window -h
tmux select-pane -t 1
tmux split-window -v
tmux select-pane -t 3

tmux next-window

tmux a
