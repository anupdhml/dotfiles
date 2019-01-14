# Config file for bash
# Executed by bash(1) for non-login shells.

# if not running interactively, don't do anything
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
#export HISTCONTROL="ignoreboth:erasedups"
export HISTCONTROL="ignoreboth"

# prevent some frequently used commands from appearing in the history file
export HISTIGNORE="&:[bf]g:l[als]:lal:exit:fortune:clear:history:du:df*:free*:git d:git ds:git b:git s:git su:git sh:git lg:git rb"

# path vars ####################################################################

# add some more paths for command discovery
export PATH="${PATH}:~/.local/bin"

# for shared libraries
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:~/.local/lib"

# easily jump to directories (apart from ones in the current dir)
#export CDPATH=".:~/repos:~/wf/repos"

# cowsay
#export COWPATH="/usr/share/cowsay/cows:~/data/cows/my_cows:~/data/cows/other_cows"
#COW_BASE_DIR="~/data/cows"
#export COWPATH="${COW_BASE_DIR}/my_cows:${COW_BASE_DIR}/other_cows:${COW_BASE_DIR}/aur_cows:${COW_BASE_DIR}/ubuntu_cows"

# airflow
if [ -d "/wayfair/app/airflow" ]; then
  export AIRFLOW_HOME="/wayfair/app/airflow"
fi

# java
export JAVA_HOME="/usr/lib/jvm/default-java"

# golang
export GOPATH="${HOME}/go"
export PATH="${PATH}:${GOPATH}/bin:/usr/local/go/bin"

# haskell
export PATH="${PATH}:~/.cabal/bin"

# color vars ###################################################################

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# colors for ls. sets LS_COLORS
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# for color terminals, make man pages colorful
if [[ "$TERM" == *"color"* ]]; then
  export LESS_TERMCAP_mb=$'\E[0;32m'    # begin blink (green)
  export LESS_TERMCAP_md=$'\E[0;32m'    # begin bold (green)
  export LESS_TERMCAP_me=$'\E[0m'       # end bold/blink
  export LESS_TERMCAP_so=$'\E[1;40;37m' # begin standout (black bg, white fg)
  export LESS_TERMCAP_se=$'\E[0m'       # end standout
  export LESS_TERMCAP_us=$'\E[0;31m'    # begin underline (red)
  export LESS_TERMCAP_ue=$'\E[0m'       # end underline
fi

# other vars ###################################################################

# make less more friendly for non-text input files, see lesspipe(1)
# sets LESSOPEN
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# remove quotes from ls output (for filenames with space)
export QUOTING_STYLE="literal"

# vi all the way
export EDITOR="vi"
export VISUAL="vi"

# config file for bat
export BAT_CONFIG_PATH="${HOME}/.bat.conf"

# sources ######################################################################

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

# fasd initialization: https://github.com/clvv/fasd#install
# modifies the prompt function
fasd_cache="${HOME}/.fasd-init-bash"
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

# ~/bin sources ################################################################

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

  # nice tmux startup (resurrecting old sessions as well)
  #~/bin/tmux_start.sh
fi
