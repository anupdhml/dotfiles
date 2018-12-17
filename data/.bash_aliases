# Alias definitions.

# command overrides ###########################################################

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Make the commands interactive and verbose
alias rm="rm -vI"
alias rmdir="rmdir -v"
alias cp="cp -iv"
alias mv="mv -iv"
alias killall='killall -u $USER -v'

# Make the command output more readable
alias du='du -kh'
alias df='df -kTh'
alias free='free -h'

# this ensures that aliases work with sudo
alias sudo='sudo '

# always start these apps in maximized mode
alias xfce4-terminal="xfce4-terminal --maximize"

# new commands ################################################################

# useful ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# better less
alias vless='/usr/share/vim/vim80/macros/less.sh'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# tmux initialization
alias tmux-start="tmux attach-session -d || tmux new-session"

# urxvt with tmux
alias urxvt-tmux='urxvt -e bash -c "(tmux -q has-session &> /dev/null && exec tmux attach-session -d) || (exec tmux new-session)"'

# directory navigation #########################################################

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."

# show entry in dirs line-by-line with number
alias dirs="dirs -v"

# change directory
cd() {
  if [ "$#" = "0" ]; then
    pushd ${HOME} > /dev/null
  else
    pushd "$1" > /dev/null
  fi
}

# back directory
bd() {
  if [ "$#" = "0" ]; then
    dirs -v
    echo -n "? "
    read choice
  else
    choice="$1"
  fi
  for i in $(seq "$choice"); do
    popd > /dev/null
  done
}

# pick directory (rotates it in the stack)
# TODO make pd only bring the selection to the top (like in zsh)
# also use fzf for fuzzy matches
pd() {
  if [[ $# -ge 1 ]]; then
    choice="$1"
  else
    dirs -v
    echo -n "? "
    read choice
  fi
  if [[ -n $choice ]]; then
    declare -i cnum="$choice"
    #if choice is not numeric, do substring match on the input
    if [[ $cnum != $choice ]]; then
      choice=$(dirs -v | grep $choice | tail -1 | awk '{print $1}')
      cnum="$choice"
      if [[ -z $choice || $cnum != $choice ]]; then
        echo "$choice not found"
        return
      fi
    fi
    choice="+$choice"
  fi
  pushd $choice > /dev/null
}

# find directory (fuzzy)
fd() {
  if [[ $# -ge 1 ]]; then
    fzy_cmd="fzy -e ${1}"
  else
    fzy_cmd="fzy"
  fi
  matched_dir=$(find . -type d | $fzy_cmd | head -n 1)
  if [[ -z "$matched_dir" ]]; then
    if [[ -n "$1" ]]; then
      echo "${1} not found"
    fi
    return 1
  fi
  cd "$matched_dir"
}

# fasd ########################################################################

# defaults (override as needed)
# https://github.com/clvv/fasd
#alias a='fasd -a'        # any
#alias s='fasd -si'       # show / search / select
#alias d='fasd -d'        # directory
#alias f='fasd -f'        # file
#alias sd='fasd -sid'     # interactive directory selection
#alias sf='fasd -sif'     # interactive file selection
#alias z='fasd_cd -d'     # cd, same functionality as j in autojump
#alias zz='fasd_cd -d -i' # cd with interactive selection

# custom
alias o='a -e xdg-open' # quick opening files with xdg-open
alias v='f -e vim'      # quick opening files with vim
alias vv='f -t -e vim -b viminfo' # quick opening files with vim (based on viminfo)

# enable auto-completion on the custom aliases
# (works only after fasd initialization)
_fasd_bash_hook_cmd_complete o v vv

# git #########################################################################

#alias gits='git status'
#alias gitsf='git status -suno'
#alias gitc='git checkout'
#alias gitd='git diff'
#alias gitds='git diff --staged'
#alias gita='git add'
#alias gitp='git pull'
#alias gitb='git branch'
#alias gitcm='git commit -m'
#alias gitcam='git commit -a -m'
#alias gitsh='git sh'

# just for fun ################################################################

# make sl less annoying (allow ctrl-c to cancel)
alias sl="sl -aFe"
alias SL="sl -aFe"
