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
export CDPATH=.:~/repos:~/wf/repos

# remove quotes from ls output (for filenames with space)
export QUOTING_STYLE=literal

# synatx highlighting for less
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -R '

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

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
#export HISTCONTROL=ignoreboth
export HISTCONTROL=erasedups:ignoreboth

# prevent some frequenty used commands from appearing in the history file
export HISTIGNORE="&:[bf]g:ls:ll:la:exit:fortune:clear:history"

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

# awesome prompt
source ~/bin/.personal_bash_prompt.sh

# fasd initialization: https://github.com/clvv/fasd#install
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

# startup ######################################################################

# if not inside a tmux session, and if no session is started, start a new session
#[ -z "$TMUX"  ] && { tmux attach || tmux new-session;}

# solve ssh issues in tmux
# TODO test this out
#source ~/bin/ssh-find-agent.bash

# welcome message
source ~/bin/.welcome.sh
