#!/usr/bin/env bash
# Generate a useful PS1 for personal use

# Functions ###################################################################

# for showing the return status of last-ran command
smileyfunct() {
  local ret_val=$?
  if [ "$ret_val" = "0" ]; then
    echo "|^◡^|"
  else
    echo -e "\e[0;31m|T_T|${ret_val}|\e[0m"
  fi
}

# for shortening the work path when it gets long 
shortpath() {
    local PRE= NAME="$1" LENGTH=35;
    [[ "$NAME" != "${NAME#$HOME/}" || -z "${NAME#$HOME}" ]] &&
        PRE+='~' NAME="${NAME#$HOME}" LENGTH=$[LENGTH-1];
    ((${#NAME}>$LENGTH)) && NAME="/...${NAME:$[${#NAME}-LENGTH+4]}";
    echo "$PRE$NAME"
}

# Variables ###################################################################

# Defaults
name="\u@\h"
prompt_end="$"
name_color=35; path_color=34 # pink/blue

# configs for __git_ps1 function (sourced from /etc/bash_completion.d/git-prompt)
GIT_PS1_SHOWDIRTYSTATE=yes
#GIT_PS1_SHOWUNTRACKEDFILES=yes
#GIT_PS1_SHOWSTASHSTATE=yes
#GIT_PS1_SHOWUPSTREAM="auto"
#GIT_PS1_SHOWCOLORHINTS=yes

# overrides for production hosts
if [[ "$HOSTNAME" == *".host."* || "$HOSTNAME" == *".sec."* ]]; then
  name_color=35; path_color=31 # pink/blue; red
fi

# overrides for root user
if [ "$EUID" -eq 0 ]; then
  name="root"
  prompt_end="#"
  name_color=31; path_color=31 # red
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
  PS1='$(smileyfunct)\[\033[01;${name_color}m\]${name}:\[\033[01;${path_color}m\]$(shortpath "$PWD")\[\033[01;30m\]$(__git_ps1 "(%s)")\[\033[00m\]${prompt_end} '
else
  PS1='\u@\h:\w\$ '
fi

# empty line before prompt
PS1="\n$PS1"

# good usage example
#Green="\033[0;32m"
#Yellow="\033[1;33m"
#Normal="\033[0m"
#PS1="\[$Yellow\]\u@\h\[$Normal\]:\[$Green\]\w \$(smileyfunct) \[$Normal\]"

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
