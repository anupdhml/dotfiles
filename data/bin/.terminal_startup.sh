#!/bin/bash
# Script meant to be used for printing welcome message on terminal startup
# Display either fortunecow or the calendar
# By anupdhml

FORTUNE_BASE_DIR="${HOME}/data/fortunes"

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

MAX_NUM=6

if [ "$[$RANDOM % $MAX_NUM]" -le 4 ]; then
  # -e treats all fortune sources equally
  #~/bin/fortunecow -e $FORTUNE_BASE_DIR/*/
  #~/bin/fortunecow -e $fortune_paths

  # based on no of fortunes
  #~/bin/fortunecow $FORTUNE_BASE_DIR/*/
  #~/bin/fortunecow $fortune_paths # remove big folder when using this

  fortune | cowsay
else
  ##calcurse -a
  #calcurse -a -r1
  #calendar -l 0
  #echo ""

  echo "$(date '+%b %d') in history and elsewhere:"
  calendar -l 0 | sed 's/[a-zA-Z]* [0-9]*\(.*\)/\1/g'
fi

# if not inside a tmux session, and if no session is started, start a new session
#[ -z "$TMUX"  ] && { tmux attach-session -d || tmux new-session; }

if [ -z "$TMUX"  ]; then
  #tmux-start
  tmux -q has-session &> /dev/null && tmux list-sessions
fi

return 0
