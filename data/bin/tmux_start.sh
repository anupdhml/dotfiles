#!/bin/bash
# Script for nice tmux startup
#
# Attaches to the last used session from the available ones.
# If no sessions are available, tries to resurrect the last saved
# sessions.
#
# Resurrect functionality depends on https://github.com/tmux-plugins/tmux-resurrect
#
# By anupdhml

if [ -n "$TMUX" ]; then
  echo "Already in a tmux session"
  exit 0
fi

# function to handle the resurrection cleanly, without leaving any blank
# sessions (which is necessary to bootstrap the operation)
_tmux_resurrect() {
  local RESURRECT_BOOTSTRAP_SESSION="_resurrect_bootstrap"

  # directories for plugins and saved sessions
  local TMUX_PLUGINS_DIR="${HOME}/.tmux/plugins"
  local TMUX_RESURRECT_DIR="${HOME}/.tmux/resurrect"

  # resurrection helper
  __run_resurrect() {
    while ! tmux run-shell "${TMUX_PLUGINS_DIR}/tmux-resurrect/scripts/restore.sh"; do
      sleep 0.2
    done

    no_of_sessions=$(tmux list-sessions | wc -l)

    # if no of sessions now is greater than 1, we resurrected some sessions and
    # no longer need the bootstrap session. This also takes care of the (rare)
    # case when we have the only resurrected session has the same name as the
    # bootstrap session (in this case, tmux-resurrect will have already
    # overwritten the bootstrap with the restored session and we don't want to
    # clear the only existing session).
    if [ "$no_of_sessions" -gt 1 ]; then
      tmux kill-session -t "$RESURRECT_BOOTSTRAP_SESSION"
    fi

    # some diagnostics
    local resurrected_sessions="$(tmux list-sessions)"
    local no_of_resurrected_sessions=$(echo "$resurrected_sessions" | wc -l)
    local resurrected_session_names=$(echo "$resurrected_sessions" | cut -d':' -f1 | tr '\n' '  ')

    # send the diagnostic message to the active session statusbar
    tmux display-message "Resurrected ${no_of_resurrected_sessions} sessions: ${resurrected_session_names}"
  }

  # Resurrect the last saved sessions (if they exist). This is done in the
  # background and will succeed once tmux starts up (next command here).
  if [ -f "${TMUX_RESURRECT_DIR}/last" ]; then
    __run_resurrect &
  else
    echo "File not found for last saved sessions"
    return 1
  fi

  # Start tmux to help with the resurrect. After resurrection, the bootstrap
  # session will be cleared (in __run_resurrect)
  tmux new-session -s "$RESURRECT_BOOTSTRAP_SESSION"
}

###############################################################################

if tmux -q has-session &> /dev/null; then
  # if the session is already attached, it will be detached from the other clients
  echo "Attaching last used session..."
  tmux attach-session -d
else
  echo "There are no active sessions. Resurrecting last saved sessions..."
  _tmux_resurrect; resurrection_status=$?

  if [ "$resurrection_status" -eq 0 ]; then
    echo "Resurrected some sessions!"
  else
    echo "Could not resurrect :( Starting a blank session..."
    tmux new-session
  fi
fi

exit 0
