# faster cd navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."

# show entry in dirs line-by-line with number
alias dirs="dirs -v"

# change directory
function cd() {
  if [ "$#" = "0" ]; then
    pushd ${HOME} > /dev/null
  else
    pushd "$1" > /dev/null
  fi
}

# back directory
function bd(){
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
function pd() {
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

##############################################################################

# faster git navigation
alias gits='git status'
alias gitsf='git status -suno'
alias gitc='git checkout'
alias gitd='git diff'
alias gitds='git diff --staged'
alias gita='git add'
alias gitp='git pull'
alias gitb='git branch'
alias gitcm='git commit -m'
alias gitcam='git commit -a -m'
