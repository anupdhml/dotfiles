#!/bin/sh
# a place to specify startup programs

##gtk-redshift &
redshift -l 43.7:-72.3 &

#xbindkeys &

devilspie &

#urxvt daemon
urxvtd -q -f
#urxvtd -q -f -o
#urxvt -e bash -c "tmux attach -d -t mysession" &
#urxvt -e bash -c "tmux -q has-session && exec tmux attach-session -d || exec tmux new-session -n$USER -s$USER@$HOSTNAME"

#tmux sessions
#~/bin/tmux-coding.sh

##~/bin/WhatPulse &

#~/.conkycolors/bin/conkyStart
#i#~/bin/startconky.sh 25 &

#check gmail
##(sleep 25 && ~/bin/startup_gmailcheck.sh) &

# desktop apps
firefox &
#xpad &

#synapse &

#mpd &

#pidof mpdscribble >& /dev/null
#if [ $? -ne 0 ]; then
    #mpdscribble &
#fi
#mpd && mpdscribble &
