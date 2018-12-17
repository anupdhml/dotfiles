#!/bin/bash
# Script meant to be run during terminal startup, for displaying welcome messages
#
# By anupdhml

# variables ####################################################################

#FORTUNE_BASE_DIR="${HOME}/data/fortunes"

#fortune_paths="/usr/share/games/fortunes/"
#fortune_paths=" $FORTUNE_BASE_DIR/my_fortunes \
    #$FORTUNE_BASE_DIR/ascii-art/ \
    #$FORTUNE_BASE_DIR/bmc_fortunes/ \
    #$FORTUNE_BASE_DIR/comp/ \
    #$FORTUNE_BASE_DIR/esr_fortunes/ \
    #$FORTUNE_BASE_DIR/mario_fortunes/ \
    #$FORTUNE_BASE_DIR/others/ \
    #$FORTUNE_BASE_DIR/pop/ \
    #$FORTUNE_BASE_DIR/shlomif_fortunes/ \
    #$FORTUNE_BASE_DIR/ubuntu_fortunes/ \
    #$FORTUNE_BASE_DIR/ubuntu_fortunes/off/ \
    #$FORTUNE_BASE_DIR/others_BIG/ \
    #"

# helpers #####################################################################

_get_today_calendar() {
  calendar -l 0 | cut -d$'\t' -f2-
}

_get_random_cowfile() {
  files=(/usr/share/cowsay/cows/*)
  printf "%s\n" "${files[RANDOM % ${#files}]}"
}

# main ########################################################################

if [ "$[$RANDOM % 4]" -eq 0 ]; then
  # run this roughly 1 in 4 times
  echo "$(date '+%b %d') in history and elsewhere:"
  _get_today_calendar | sed 's/^/    /'
else
  # -e treats all fortune sources equally
  #~/bin/fortunecow -e $FORTUNE_BASE_DIR/*/
  #~/bin/fortunecow -e $fortune_paths

  # based on no of fortunes
  #~/bin/fortunecow $FORTUNE_BASE_DIR/*/
  #~/bin/fortunecow $fortune_paths # remove big folder when using this

  fortune | cowsay -f $(_get_random_cowfile)
fi

# Show info on available tmux sessions (if any)
if $(tmux -q has-session &> /dev/null); then
  echo ""
  echo "Available tmux sessions:"
  tmux list-sessions | sed 's/^/    /'
fi

# if not inside a tmux session, and if no session is started, start a new session
#[ -z "$TMUX"  ] && { tmux attach-session -d || tmux new-session; }
#tmux-start

return 0
