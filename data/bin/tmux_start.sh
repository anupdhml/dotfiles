#!/bin/bash
# Script for nice tmux startup
#
# Attaches to the last used session from the available ones.
# If no sessions are available, tries to resurrect the last saved
# session.
#
# Resurrect functionality depends on https://github.com/tmux-plugins/tmux-resurrect
#
# By anupdhml

if [ -n "$TMUX" ]; then
  echo "Already in a tmux session"
  exit 0
fi

# directories for plugins and saved sessions
TMUX_PLUGIN_DIR="${HOME}/.tmux/plugins"
TMUX_RESURRECT_DIR="${HOME}/.tmux/resurrect"

# resurrection helper
_tmux_resurrect() {
  while ! tmux run-shell "${TMUX_PLUGIN_DIR}/tmux-resurrect/scripts/restore.sh"; do
    sleep 0.2;
  done

  # we don't need the dummy window now
  # TODO if there were no sessions to restore, this effectively kills tmux
  # start a session without special name in that case
  tmux kill-session -t _resurrect_helper
}

###############################################################################

if tmux -q has-session &> /dev/null; then
  # attaches the last used session (detaching it from any clients as well)
  tmux attach-session -d
else
  # no session has been started. try to resurrect the last saved session (if it
  # exists). This is done in the background and will succeed once tmux starts up
  # (next command here)
  [ -f "${TMUX_RESURRECT_DIR}/last" ] && _tmux_resurrect &

  # start tmux
  tmux new-session -s _resurrect_helper
fi

exit 0
