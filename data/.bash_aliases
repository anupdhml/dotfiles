# File for bash alias definitions

# command overrides (colors/usability) ########################################

# enable color support of ls and also add -v option
# (natural sort of numbers within text)
alias ls='ls --color=auto -v'

# enable color support of grep and also ignore case
alias grep='grep --color=auto --ignore-case'
alias fgrep='fgrep --color=auto --ignore-case'
alias egrep='egrep --color=auto --ignore-case'

if [[ "$TERM" == *"color" ]]; then
  # on color terminals, fool certain commands to always print in color
  # (useful to see color when piping to places like less)
  alias diff='diff --color=always'
  alias dmesg='dmesg --color=always'
else
  # enable auto color support elsewhere
  alias diff='diff --color=auto'
  alias dmesg='dmesg --color=auto'
fi

# improved less (with color support)
alias less='less --ignore-case --long-prompt --RAW-CONTROL-CHARS'

# via generic colorizer
GRC="$(which grc)"
if [ -n GRC ]; then
  alias colorify="${GRC} -es --colour=auto"

  alias configure='colorify ./configure'
  #alias gcc='colorify gcc'
  #alias g++='colorify g++'
  #alias ld='colorify ld'
  #alias make='colorify make'

  alias netstat='colorify netstat'
  alias ping='colorify ping'
  alias tcpdump='colorify tcpdump'
  alias traceroute='colorify traceroute'
fi

# command alternatives that have color support
#alias make='colormake'
#alias tail='colortail'

# command overrides (usability) ###############################################

# make the commands interactive and verbose
alias rm='rm -vI'
alias rmdir='rmdir -v'
alias cp='cp -iv'
alias mv='mv -iv'
alias killall='killall -u $USER -v'

# make the command output more readable
alias du='du -kh'
alias df='df -kTh'
alias free='free -h'

# prefer human numeric sort by default
alias sort='sort -h'

# this ensures that aliases work with sudo
alias sudo='sudo '

# always start these apps in maximized mode
alias xfce4-terminal='xfce4-terminal --maximize'

# command extensions ##########################################################

# useful ls aliases
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -Alh'
alias lal='ll -A'
alias lsd='ll | grep "^d"'    # list only directories
alias lsf='ll | grep -v "^d"' # list only files

# capturing frequently used patterns
alias g='xdg-open' # open in gui
alias psg='ps auxw | grep $1'
alias fnd='find . -iname $1'

# easy linking
lns() {
  ln -sfv "$(pwd)/${1}" "$2"
}

# tree representation of processes
alias ps-tree='ps -e -o pid,ppid,command --forest'

# update packages
alias apt-update='sudo apt-get update; sudo apt-get upgrade && sudo apt-get autoremove'

# use vim like less
alias vless='/usr/share/vim/vim80/macros/less.sh'

# terminals with tmux
alias xfce4-terminal-tmux='xfce4-terminal --maximize -e "bash -c ~/bin/tmux_start.sh"'
alias urxvt-tmux='~/bin/urxvtcd -e bash -c "~/bin/tmux_start.sh"'
#alias urxvt-tmux='~/bin/urxvtcd -e bash -c "(tmux -q has-session &> /dev/null && exec tmux attach-session -d) || (exec tmux new-session)"'

# utilities ##########################################################

# Add an "alert" alias for long running commands.  Use like so: sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# supply input as $1
alias pdf-combine='gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=combined.pdf $1'
alias pdf-from-images='convert -adjoin -page A4 $1 images.pdf'

# test terminal color capabilities
alias colortest-msgcat='msgcat --color=test'

# Copy terminfo for the current terminal to a remote host (provided as $1).
# Use if you get "unknown terminal type" error in the remote host (eg: when
# clearing the screen). This is necessary for terminals like rxvt-unicode256color,
# whose terminfo file is not widely installed.
alias terminfo-copy='infocmp "$TERM" | ssh $1 "mkdir -p ~/.terminfo && cat >/tmp/ti && tic /tmp/ti && rm /tmp/ti"'

# directory navigation #########################################################

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'

# show entry in dirs line-by-line with number
alias dirs='dirs -v'

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

# development ##################################################################

# C
alias gccmine='gcc -Wall -pedantic -std=c99 -ggdb'
alias gccminenodb='gcc -Wall -pedantic -std=c99'
alias valgrind-memcheck='valgrind --leak-check=yes'

# better beeline for hive queries
# TODO version control hive too
alias beez="beeline -i ~/.hiverc -u jdbc:hive2://${HIVE_SERVER}:10000 -n $USER --verbose=true --showWarnings=true showNestedErrs=true --color=true --silent=false"

# just for fun ################################################################

# make sl less annoying (allow ctrl-c to cancel)
alias sl='sl -e'
alias SL='sl -e'

# powered by internet
alias funfacts='wget http://www.randomfunfacts.com -O - 2>/dev/null | grep \<strong\> | sed "s;^.*<i>\(.*\)</i>.*$;\1;";'
alias freechess='telnet fics.freechess.org 5000'

# get etymology of the given words
# TODO fix this
etymology() {
  for term in "$@"; do
    url="https://www.etymonline.com/word/${term}"
    curl -s "$url" | grep "<dd " |
        sed -e 's/<a[^>]*>\([^<]*\)<[^>]*>/:\1:/g' -e 's/<[^>]*>//g' |
        fold -sw `[ $COLUMNS -lt 80 ] && echo $COLUMNS || echo 79 `
    echo
  done
}

# weather function
wttr() {
  local request="wttr.in/${1-Boston}?T&m"
  [ "$COLUMNS" -lt 125 ] && request+='&n'
  curl --header "Accept-Language: ${LANG%_*}" --compressed --silent "$request"
}
