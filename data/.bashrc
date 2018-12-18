# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

# shell options ###############################################################

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# auto-correct typos in directory names
shopt -s cdspell

# env vars ####################################################################

# easily jump to directories (apart from ones in the current dir)
#export CDPATH=.:~/repos:~/wf/repos

# remove quotes from ls output (for filenames with space)
export QUOTING_STYLE=literal

# vi all the way
export EDITOR="vi"
export VISUAL="vi"

# for color terminals, make man pages colorful
if [[ "$TERM" == *"color" ]]; then
  export LESS_TERMCAP_mb=$'\E[0;31m'    # begin blinking red
  export LESS_TERMCAP_md=$'\E[0;31m'    # begin bold red
  export LESS_TERMCAP_me=$'\E[0m'       # end mode
  export LESS_TERMCAP_se=$'\E[0m'       # end standout-mode
  export LESS_TERMCAP_so=$'\E[1;40;37m' # begin standout-mode - info box white
  export LESS_TERMCAP_ue=$'\E[0m'       # end underline
  export LESS_TERMCAP_us=$'\E[0;32m'    # begin underline green
fi

# for cowsay
#export COWPATH="/usr/share/cowsay/cows:$HOME/data/cows/my_cows:$HOME/data/cows/other_cows"
#COW_BASE_DIR=$HOME/data/cows
#export COWPATH="$COW_BASE_DIR/my_cows:$COW_BASE_DIR/other_cows:$COW_BASE_DIR/aur_cows:$COW_BASE_DIR/ubuntu_cows"

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# history ######################################################################

# append to the history file, don't overwrite it
shopt -s histappend

# force commands that you entered on more than one line to be adjusted to fit on only one
shopt -s cmdhist

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=1000000
export HISTFILESIZE=999999

# timestamp the history entry
export HISTTIMEFORMAT="%h %d %H:%M:%S "

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
#export HISTCONTROL=ignoreboth:erasedups
export HISTCONTROL=ignoreboth

# prevent some frequenty used commands from appearing in the history file
export HISTIGNORE="&:[bf]g:l[als]:lal:exit:fortune:clear:history:du:df*:free*"

# sources #####################################################################

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  fi
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# fasd initialization: https://github.com/clvv/fasd#install
# modifies the prompt function
fasd_cache="$HOME/.fasd-init-bash"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

# alias definitions
# making this the final item here, since aliases may utilize stuff already sourced
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# ~/bin sources ##############################################################

# awesome prompt
# make sure that this is the last thing that modifies the prompt function
# (eg: by placed this after things like fasd initialization)
source ~/bin/.bash_prompt.sh

# solve ssh issues in tmux
# TODO test this out
#source ~/bin/ssh-find-agent.bash

# all the stuff we don't want running when inside a tmux session
if [ -z "$TMUX" ]; then
  # display a nice welcome message
  ~/bin/.terminal_welcome.sh

  # if no tmux session has been started, start it. otherwise attach to the existing one
  #tmux attach-session -d || tmux new-session
fi
