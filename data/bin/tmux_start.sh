#!/bin/bash
# Simple script to start tmux up

if [ -z "$TMUX" ]; then
  # if no tmux session has been started, start it. otherwise attach to the existing one
  tmux attach-session -d || tmux new-session
else
  echo "Already in a tmux session"
fi

exit 0
