# ~/.bash_logout: executed by bash(1) when login shell exits.

# when leaving the console clear the screen to increase privacy

if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi

# copies .bash_history elsewere, runs it through awk to unique it
# (without having to sort, which removes context), then puts it back in place.
#
# awk magic below
# It removes duplicate lines without messing up ordering. x is a hash table.
# x[$0] is the value in the hash table with key $0, which is the string of the entire line.
# When the line first comes up, x[$0] is not set and x[$0]++ set x[$0] to 1 and returns 0.
# Negating 0 yields 1, and the line is then printed. But on any subsequent appearance of that line,
# x[$0] will be greater than 0 and negating it will yield 0, and the line will not get printed.
#
#cat ~/.bash_history >> ~/.history_full
#awk '!x[$0]++' ~/.history_full > ~/.bash_history
#\cp ~/.bash_history ~/.history_full

# save the tmux sessions. can lead to empty last file so disabling
#~/.tmux/plugins/tmux-resurrect/scripts/save.sh quiet
