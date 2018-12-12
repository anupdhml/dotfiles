#!/usr/bin/env bash
# Generate a useful PS1 for personal use

# Functions ###################################################################

# for showing the return status of last-ran command
__smileyfunct() {
  local ret_val=$?
  if [ "$ret_val" = "0" ]; then
    echo "|^◡^|"
  else
    # print with red
    echo -e "\e[0;31m|T_T|${ret_val}|\e[0m"
  fi
}

# for shortening the work path when it gets long 
__shorten_path() {
  local pre= name="$1" length=35;
  [[ "$name" != "${name#$HOME/}" || -z "${name#$HOME}" ]] &&
    pre+='~' name="${name#$HOME}" length=$[length-1];
  ((${#name}>$length)) && name="/...${name:$[${#name}-length+4]}";
  echo "$pre$name"
}

# Variables ###################################################################

# Defaults
name="${LOGNAME}@${HOSTNAME%%.*}"
prompt_end="$"

# colors
name_color=$'\e[01;35m'    # pink
path_color=$'\e[01;34m'    # blue
git_color=$'\e[01;30m'     # black
prompt_end_color=$'\e[00m' # black (light)

# configs for __git_ps1 function (sourced from /etc/bash_completion.d/git-prompt)
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWDIRTYSTATE=yes
#GIT_PS1_SHOWUNTRACKEDFILES=yes
#GIT_PS1_SHOWSTASHSTATE=yes
#GIT_PS1_SHOWCOLORHINTS=yes

# overrides for production hosts
if [[ "$HOSTNAME" == *".host."* || "$HOSTNAME" == *".sec."* ]]; then
  path_color=$'\e[01;31m' # red
fi

# overrides for root user
if [ "$EUID" -eq 0 ]; then
  prompt_end="#"
  name_color=$'\e[01;31m' # red
  path_color=$'\e[01;31m' # red
fi

# overrides for home user
if [ $LOGNAME = anup ]; then
  # overrides for home user
  name_list=(anup अनुप ανουπ)
  name=${name_list[ RANDOM % ${#name_list[@]} ]}
fi

# set fancy prompt only for certain terminals
case "$TERM" in
  xterm-color|*-256color) fancy_prompt=yes;;
esac

###############################################################################

if [ "$fancy_prompt" = yes ]; then
  #PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  PS1='$(__smileyfunct)\[${name_color}\]${name}:\[${path_color}\]$(__shorten_path "$PWD")\[${git_color}\]$(__git_ps1 "(%s)")\[${prompt_end_color}\]${prompt_end} '
else
  PS1='\u@\h:\w\$ '
fi

# empty line before prompt
PS1="\n$PS1"

## cool prompt
#function bash_prompt {
  #if [[ $? -eq "0" ]]; then
     #SMILEY=" ${LG}^◡^${NONE} ";
   #else
     #SMILEY=" ${LR}ಠ_ಠ${NONE} ";
  #fi

  #local UC=$LG
  #[ $UID -eq "0" ] && UC=$LR

  #TITLEBAR="${UC}\u${LW}:${LB}${PWD}${NONE}"

  #PS1="$SMILEY${TITLEBAR}${LW} > "
  #PS2="                                                                                                                                                                                                      "
  #PS2="${PS2:0:$(( $(echo $PWD | wc -c) + $(whoami | wc -c) + 4))}${EMW} > "

  #echo -n -e "\a"
#}
#trap '/bin/echo -n -e "\e[0m"' DEBUG
#PROMPT_COMMAND=bash_prompt
