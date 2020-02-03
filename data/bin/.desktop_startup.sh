#!/bin/bash
# Script meant to be run during desktop startup, for starting GUI applications
# By anupdhml

# make sure we pick up changes in Xresources file
# TODO this should not be necessary but leaving it here for now since Xft.dpi changes
# here are not being picked up without it.
xrdb -merge ~/.Xresources

# launcher
synapse --startup &

# web browser
#firefox &

# miscellaneous desktop applications
#redshift &

# terminal
# start the urxvt daemon (better for urxvt performance with multiple windows)
# and then spawn a terminal instance with tmux
# (tmux_start.sh will restore last saved tmux sessions as well)
~/bin/urxvtcd -e bash -c "~/bin/tmux_start.sh"
# without the urxvtcd script
#urxvtd --quiet --opendisplay --fork && urxvtc -e bash -c "~/bin/tmux_start.sh"
# without the daemon
#urxvt -e bash -c "~/bin/tmux_start.sh" &

exit 0
