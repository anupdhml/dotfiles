#!/usr/bin/env bash

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	  color_prompt=yes
  else
	  color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*)
  ;;
esac

###############################################################################

# for PS1
kernel_version=$(uname -r)
if [ -z "$DISPLAY" ] && [ -z "$SSH_CONNECTION" ]; then
    name="anup-$kernel_version"
    #smiley=":)"
    #frown=":("
    smiley=""
    frown="!"
else
    name_list=(anup अनुप ανουπ)
    no_of_names=${#name_list[@]}
    name=${name_list[RANDOM%$no_of_names]}
    #name=""
    smiley="|^◡^|"
    frown="|T_T|"
    #frown="|ಠ_ಠ|"
fi

if [ $TERM == linux ] && [ $(tty) == /dev/tty1 ] ; then
  namecol=32; dircol=32 # all green in tty1
else
  namecol=35; dircol=34 # pink, blue
  #namecol=28; dircol=34 # black, blue
fi

# to show the return status
smileyfunct() {
    ret_val=$?
    if [ "$ret_val" = "0" ]
    then
        echo "$smiley"
        #echo -e "\e[1;${namecol}m${smiley}\e[0m"
    else
        #echo "$frown"
        #echo "$frown($ret_val)"
        #echo -e "\e[1;31m${frown}"
        echo -e "\e[0;31m${frown}${ret_val}|\e[0m"
    fi
}

ps1_path_length=35
shortpath() {
    local PRE= NAME="$1" LENGTH=$ps1_path_length;
    [[ "$NAME" != "${NAME#$HOME/}" || -z "${NAME#$HOME}" ]] &&
        PRE+='~' NAME="${NAME#$HOME}" LENGTH=$[LENGTH-1];
    ((${#NAME}>$LENGTH)) && NAME="/...${NAME:$[${#NAME}-LENGTH+4]}";
    echo "$PRE$NAME"
}

# for showing git related stuff in the prompt
#source ~/bin/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=yes

#GIT_PS1_SHOWSTASHSTATE=yes
#GIT_PS1_SHOWCOLORHINTS=yes
#GIT_PS1_SHOWUPSTREAM="auto"
#GIT_PS1_SHOWUNTRACKEDFILES=yes

# 100% pure Bash (no forking) function to determine the name of the current git branch
gitbranch() {
    export GITBRANCH=""

    local repo="${_GITBRANCH_LAST_REPO-}"
    local gitdir=""
    [[ ! -z "$repo" ]] && gitdir="$repo/.git"

    # If we don't have a last seen git repo, or we are in a different directory
    if [[ -z "$repo" || "$PWD" != "$repo"* || ! -e "$gitdir" ]]; then
        local cur="$PWD"
        while [[ ! -z "$cur" ]]; do
            if [[ -e "$cur/.git" ]]; then
                repo="$cur"
                gitdir="$cur/.git"
                break
            fi
            cur="${cur%/*}"
        done
    fi

    if [[ -z "$gitdir" ]]; then
        unset _GITBRANCH_LAST_REPO
        return 0
    fi
    export _GITBRANCH_LAST_REPO="${repo}"
    local head=""
    local branch=""
    read head < "$gitdir/HEAD"
    case "$head" in
        ref:*)
            branch="${head##*/}"
            ;;
        "")
            branch=""
            ;;
        *)
            branch="d:${head:0:7}"
            ;;
    esac
    if [[ -z "$branch" ]]; then
        return 0
    else
        echo "(${PS1_green}$branch${PS1_reset})"
    fi
}

# Change the prompt color and style.
if [ $LOGNAME = anup ] || [ $LOGNAME = adhamala ]; then
    #PS1='\n\[\033[01;34m\]\w\[\033[00m\]\$ '
    #PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;${namecol}m\]$name:\[\033[01;${dircol}m\]\w\[\033[00m\]\$ '
    #PS1="${debian_chroot:+($debian_chroot)}\[\`if [[ \$? = "0" ]]; then echo '\e[0;${namecol}m\]$smiley'; else echo '\e[0;31m\]$frown'; fi\`\]\[\033[01;${namecol}m\]$name:\[\033[01;${dircol}m\]\w\[\033[00m\]\$ "
    #PS1="${debian_chroot:+($debian_chroot)}\$(smileyfunct)\[\033[01;${namecol}m\]$name:\[\033[01;${dircol}m\]\w\[\033[01;30m\]\$(__git_ps1 \"(%s)\")\[\033[00m\]\$ "
    #" # this line is here to fix the syntax highligthing. above PS1 is valid but too many quotes garbled the highlighting
    #PS1='$(smileyfunct)\[\033[01;${namecol}m\]$name:\[\033[01;${dircol}m\]$(shortpath "$PWD")\[\033[01;30m\]$(__git_ps1 "(%s)")\[\033[00m\]\$ '
    # slower
    PS1='$(smileyfunct)\[\033[01;${namecol}m\]$name@\h:\[\033[01;${dircol}m\]$(shortpath "$PWD")\[\033[01;30m\]$(__git_ps1 "(%s)")\[\033[00m\]\$ '
    # very fast
    #PS1='$(smileyfunct)\[\033[01;${namecol}m\]$name@\h:\[\033[01;${dircol}m\]$(shortpath "$PWD")\[\033[01;30m\]$(gitbranch)\[\033[00m\]\$ '
elif [ $(id -u) -eq 0 ]; then
    PS1="\\[$(tput setaf 1)\\]\\u@\\h:\\w# \\[$(tput sgr0)\\]" # you are root, set red colour prompt
else
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ ' # Green Prompt, all other users
fi

# cool prompt
#PS1="\u@\h \[\e[33m\]\W\[\e[0m\] \[\`if [[ \$? = "0" ]]; then echo '\e[32m:)\e[0m'; else echo '\e[31m:(\e[0m' ; fi\`\] \$ "

# good usage example
#Green="\033[0;32m"
#Yellow="\033[1;33m"
#Normal="\033[0m"
#PS1="\[$Yellow\]\u@\h\[$Normal\]:\[$Green\]\w \$(smileyfunct) \[$Normal\]"

# Change the window titlebar to show current command
case "$TERM" in
xterm*|rxvt*)
    #PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
    #PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}\007"; history -a; history -n; hF'
    #PROMPT_COMMAND='history -a;history -n;hF'
    #export PROMPT_COMMAND="history -a; history -c; history -r; hF; _loghistory -h; $PROMPT_COMMAND"
    #export PROMPT_COMMAND="history -a; history -c; history -r; hF; $PROMPT_COMMAND"

    # Show the currently running command in the terminal title:
    # http://www.davidpashley.com/articles/xterm-titles-with-bash.html
    show_command_in_title_bar()
    {
        case "$BASH_COMMAND" in
            *\033]0*)
                # The command is trying to set the title bar as well;
                # this is most likely the execution of $PROMPT_COMMAND.
                # In any case nested escapes confuse the terminal, so don't
                # output them.
                ;;
            *)
                echo -ne "\033]0;${USER}@${HOSTNAME}:${PWD}: ${BASH_COMMAND}\007"
                ;;
        esac
    }
    trap show_command_in_title_bar DEBUG
    ;;
*)
    ;;
esac

#case "$TERM" in
#xterm*|rxvt*)
        ##PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}\007"'
        ##PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
        #PROMPT_COMMAND='echo -ne "\033]0;${PWD}\007"'
        ##PROMPT_COMMAND="printf '\033k$(hostname)\033\\';"${PROMPT_COMMAND}
        #;;
#*)
        #;;
#esac

#PROMPT_COMMAND='echo -en "\033]0;$PWD\007"'
#wname() { echo -en "\033]0;$@\007"; }
#alias mutt='wname mutt; mutt'

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

# empty line before prompt
PS1="\n$PS1"
