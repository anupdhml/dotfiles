# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

#if [ -d "$HOME/.local/bin" ]; then
    #PATH="$HOME/.local/bin:$PATH"
#fi

#export JAVA_HOME="/usr/lib/jvm/java-6-sun"
#export JAVA_HOME="/usr/lib/jvm/java-6-openjdk"
export JAVA_HOME="/usr/lib/jvm/default-java"

RUBY_BIN="${HOME}/.gem/ruby/*/bin"
PATH="$RUBY_BIN:$PATH"

# android stuff
PATH="$HOME/data/src/adt-bundle-linux-x86-20131030/sdk/tools:$HOME/data/src/adt-bundle-linux-x86-20131030/sdk/platform-tools:$PATH"

# If not running interactively, don't do anything
[ -z "$PS1" ] && return
#[[ $- != *i* ]] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# bash useful
#set -o xtrace -o errexit # Debug
#shopt -s nullglob
#set -o noclobber -o nounset -o pipefail
#set -o noclobber -o pipefail
set -o pipefail

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
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

#if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
    #PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    #;;
#*)
    #;;
#esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Check if the alias file is present or not. 
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

####################
# CUSTOMIZATIONS####
####################

# A simple login manager
#if ! pidof X 2>&1 > /dev/null
  #if [ -z "$DISPLAY" ] && [ $(tty) == /dev/tty1 ]
#then
#   echo -n "You want to startup X? Yy/Nn "
#    read x
#fi
#
#if [ "$x" = "y" -o "$x" = "Y" ]
#then
#    startx
#fi

###############################################################################

# History management

# append to the history file, don't overwrite it
shopt -s histappend

# force commands that you entered on more than one line to be adjusted to fit on only one
shopt -s cmdhist

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
#export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
#export HISTCONTROL=ignoreboth
export HISTCONTROL=erasedups:ignoreboth

# Show date in the history command
#export HISTTIMEFORMAT="%d/%m/%y %T "
#export HISTTIMEFORMAT='%F %T '

# large histfilesize
#export HISTSIZE=9999
export HISTSIZE=1000000
export HISTFILESIZE=999999
#unset HISTFILESIZE

# ignore these
export HISTIGNORE="&:[bf]g:ls:ll:la:exit:fortune:clear:history"
#export HISTIGNORE="&:[bf]g:exit:fortune:clear:cl:history:cat *:dict *:which *:rm *:rmdir *:shred *:man *:apropos *:sudo rm *:sudo cat *:mplayer *:source *:. *:gojo *:mutt"

## migrated to .bash_profile. For some reason, gave problems here.
# make history search easier..
#bind '"\e[A"':history-search-backward
#bind '"\e[B"':history-search-forward

# function from here will be called from $PROMPT_COMMAND
#source $HOME/bin/loghistory.sh

# Managing history
# right before prompting for the next command, save the previous command in a file.
hF()
{
  unset HISTTIMEFORMAT
  histentry="$(date +%Y-%m-%d--%H:%M:%S) ~~~ $(hostname):$PWD ~~~ $(history 1)" 
  echo "$histentry" >> ~/.full_history || echo "hF: file error." ; return 1
  #echo "$(date +%Y-%m-%d--%H:%M:%S) $PWD $(history 1)" >> ~/.full_history
  #echo "$(hostname) $PWD $(history 1)"  >> ~/.full_history
}
#PROMPT_COMMAND=histFunc

# Managing history, another method. continued in .bash_logout
# update the history file and read anything new from it every time a command completes
#export PROMPT_COMMAND="history -a; history -n"

###############################################################################

# Prompt

# Make the tty text green for tty1 and tty2. Yeah, we love matrix.
#if [ -z "$DISPLAY" ] && [ $(tty) == /dev/tty1 -o $(tty) == /dev/tty3 ] ; then
  #setterm -foreground green -background black -store
#fi

# for PS1
kernel_version=$(uname -r)
if [ -z "$DISPLAY" ]; then
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
source ~/bin/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=yes
GIT_PS1_SHOWSTASHSTATE=yes
#GIT_PS1_SHOWCOLORHINTS=yes 
#GIT_PS1_SHOWUPSTREAM="auto"
#GIT_PS1_SHOWUNTRACKEDFILES=yes 

# Change the prompt color and style.
if [ $LOGNAME = anup ]; then
    #PS1='\n\[\033[01;34m\]\w\[\033[00m\]\$ '
    #PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;${namecol}m\]$name:\[\033[01;${dircol}m\]\w\[\033[00m\]\$ '
    #PS1="${debian_chroot:+($debian_chroot)}\[\`if [[ \$? = "0" ]]; then echo '\e[0;${namecol}m\]$smiley'; else echo '\e[0;31m\]$frown'; fi\`\]\[\033[01;${namecol}m\]$name:\[\033[01;${dircol}m\]\w\[\033[00m\]\$ "
    #PS1="${debian_chroot:+($debian_chroot)}\$(smileyfunct)\[\033[01;${namecol}m\]$name:\[\033[01;${dircol}m\]\w\[\033[01;30m\]\$(__git_ps1 \"(%s)\")\[\033[00m\]\$ "
    #" # this line is here to fix the syntax highligthing. above PS1 is valid but too many quotes garbled the highlighting
    PS1='$(smileyfunct)\[\033[01;${namecol}m\]$name:\[\033[01;${dircol}m\]$(shortpath "$PWD")\[\033[01;30m\]$(__git_ps1 "(%s)")\[\033[00m\]\$ '
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
    export PROMPT_COMMAND="history -a; history -c; history -r; hF; $PROMPT_COMMAND"

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

###############################################################################

# A bit of humour, maybe..
if [ $LOGNAME = root ]
then
  clear
  echo "Remember anup, with great power comes great responsibility..." | cowsay -n -f spiderman
else
  #if [ $(tty) == /dev/tty3 ]
  #then
    #clear
  #fi
  #ddate
  #fortune
  #fortune -a | cowsay -n -f dragon-and-cow 
  ~/bin/termstartup.sh
  #echo ""
fi

###############################################################################

# synatx highlighting for less
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -R '

## migrated to .bash_profile. For some reason, gave problems here.
# Make man pages colorful, when using less
#export LESS_TERMCAP_mb=$'\E[0;31m'      # begin blinking red
#export LESS_TERMCAP_md=$'\E[0;31m'      # begin bold red
#export LESS_TERMCAP_me=$'\E[0m'          # end mode
#export LESS_TERMCAP_se=$'\E[0m'          # end standout-mode                 
#export LESS_TERMCAP_so=$'\E[1;44;33m'   # begin standout-mode - info box yellow                             
#export LESS_TERMCAP_ue=$'\E[0m'          # end underline
#export LESS_TERMCAP_us=$'\E[0;32m'      # begin underline green

# Use most to view man pages
#export MANPAGER="/usr/bin/most -s"

# Use vim to view man pages
#export PAGER="sh -c \"col -b | view -c 'set ft=man nomod nolist nonumber titlestring=MANPAGE' -c 'map q :q<CR>' -\""
#export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
    #vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
    #-c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
    #-c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""

# end emacs rule
#set -o vi

###############################################################################

# Tab completion for tmux sessions.
# Quickly open new tmux sessions in your projects dir.

# Setup:
# Source this code in your bash shell.
# Update the code_dir var with the root directory of your source code.

# Usage:

# Use the tab to open an existing session.
# $ tat [TAB]

# Arguments that are passed to tat will be used to create a new session.
# Tat will open a new tmux session and set the default path to the found dir.
# $ tat payments
# $ pwd
# /code_dir/payments

#tat()
#{
  #local session_name="$1"
  #tmux attach-session -t "$session_name"
  #if [ $? -ne 0 ]; then
    #local code_dir="/home/mel/Doc/Coding/cs50-bashC/svn_cs50"
    #local list_of_dirs=( $(find "$code_dir" -name "$session_name" -type d ) )
    #local first_found="${dirs[0]}"
    #cd "$first_found"
    #echo "tat() is creating new tmux session with name=$session_name"
    #tmux new-session -d -s "$session_name"
    #echo "tat() is setting default path with dir=$first_found"
    #tmux set default-path "$first_found"
    #tmux attach-session -t "$session_name"
  #fi
#}
#_tat()
#{
  #COMPREPLY=()
  #local session="${COMP_WORDS[COMP_CWORD]}"
  #COMPREPLY=( $(compgen -W "$(tmux list-sessions 2>/dev/null | awk -F: '{ print $1 }')" -- "$session") )
#}
#complete -F _tat tat

###############################################################################

# sneaky
#echo sleep .1 >> .bashrc

#while sleep 1;do echo ne '\033]2;'$USER@$HOSTNAME' '$(uptime)'\007';done &

#function _update_ps1() {
   #export PS1="$(~/bin/powerline-shell.py $?)"
#}

#export PROMPT_COMMAND="_update_ps1"

###############################################################################
#  Customize BASH PS1 prompt to show current GIT repository and branch.
#  by Mike Stewart - http://MediaDoneRight.com

#  SETUP CONSTANTS
#  Bunch-o-predefined colors.  Makes reading code easier than escape sequences.
#  I don't remember where I found this.  o_O

# Reset
#Color_Off="\[\033[0m\]"       # Text Reset

## Regular Colors
#Black="\[\033[0;30m\]"        # Black
#Red="\[\033[0;31m\]"          # Red
#Green="\[\033[0;32m\]"        # Green
#Yellow="\[\033[0;33m\]"       # Yellow
#Blue="\[\033[0;34m\]"         # Blue
#Purple="\[\033[0;35m\]"       # Purple
#Cyan="\[\033[0;36m\]"         # Cyan
#White="\[\033[0;37m\]"        # White

## Bold
#BBlack="\[\033[1;30m\]"       # Black
#BRed="\[\033[1;31m\]"         # Red
#BGreen="\[\033[1;32m\]"       # Green
#BYellow="\[\033[1;33m\]"      # Yellow
#BBlue="\[\033[1;34m\]"        # Blue
#BPurple="\[\033[1;35m\]"      # Purple
#BCyan="\[\033[1;36m\]"        # Cyan
#BWhite="\[\033[1;37m\]"       # White

## Underline
#UBlack="\[\033[4;30m\]"       # Black
#URed="\[\033[4;31m\]"         # Red
#UGreen="\[\033[4;32m\]"       # Green
#UYellow="\[\033[4;33m\]"      # Yellow
#UBlue="\[\033[4;34m\]"        # Blue
#UPurple="\[\033[4;35m\]"      # Purple
#UCyan="\[\033[4;36m\]"        # Cyan
#UWhite="\[\033[4;37m\]"       # White

## Background
#On_Black="\[\033[40m\]"       # Black
#On_Red="\[\033[41m\]"         # Red
#On_Green="\[\033[42m\]"       # Green
#On_Yellow="\[\033[43m\]"      # Yellow
#On_Blue="\[\033[44m\]"        # Blue
#On_Purple="\[\033[45m\]"      # Purple
#On_Cyan="\[\033[46m\]"        # Cyan
#On_White="\[\033[47m\]"       # White

## High Intensty
#IBlack="\[\033[0;90m\]"       # Black
#IRed="\[\033[0;91m\]"         # Red
#IGreen="\[\033[0;92m\]"       # Green
#IYellow="\[\033[0;93m\]"      # Yellow
#IBlue="\[\033[0;94m\]"        # Blue
#IPurple="\[\033[0;95m\]"      # Purple
#ICyan="\[\033[0;96m\]"        # Cyan
#IWhite="\[\033[0;97m\]"       # White

## Bold High Intensty
#BIBlack="\[\033[1;90m\]"      # Black
#BIRed="\[\033[1;91m\]"        # Red
#BIGreen="\[\033[1;92m\]"      # Green
#BIYellow="\[\033[1;93m\]"     # Yellow
#BIBlue="\[\033[1;94m\]"       # Blue
#BIPurple="\[\033[1;95m\]"     # Purple
#BICyan="\[\033[1;96m\]"       # Cyan
#BIWhite="\[\033[1;97m\]"      # White

## High Intensty backgrounds
#On_IBlack="\[\033[0;100m\]"   # Black
#On_IRed="\[\033[0;101m\]"     # Red
#On_IGreen="\[\033[0;102m\]"   # Green
#On_IYellow="\[\033[0;103m\]"  # Yellow
#On_IBlue="\[\033[0;104m\]"    # Blue
#On_IPurple="\[\033[10;95m\]"  # Purple
#On_ICyan="\[\033[0;106m\]"    # Cyan
#On_IWhite="\[\033[0;107m\]"   # White

## Various variables you might want for your PS1 prompt instead
#Time12h="\T"
#Time12a="\@"
#PathShort="\w"
#PathFull="\W"
#NewLine="\n"
#Jobs="\j"


# This PS1 snippet was adopted from code for MAC/BSD I saw from: http://allancraig.net/index.php?option=com_content&view=article&id=108:ps1-export-command-for-git&catid=45:general&Itemid=96
# I tweaked it to work on UBUNTU 11.04 & 11.10 plus made it mo' better

#export PS1=$IBlack$Color_Off'$(git branch &>/dev/null;\
#if [ $? -eq 0 ]; then \
  #echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
  #if [ "$?" -eq "0" ]; then \
    ## @4 - Clean repository - nothing to commit
    #echo "'$Green'"$(__git_ps1 " (%s)"); \
  #else \
    ## @5 - Changes to working tree
    #echo "'$IRed'"$(__git_ps1 " {%s}"); \
  #fi) '$BYellow$PathShort$Color_Off'\$ "; \
#else \
  ## @2 - Prompt when not in GIT repo
  #echo " '$Yellow$PathShort$Color_Off'\$ "; \
#fi)'
###############################################################################

# passing bash aliases to sudo
alias sudo='sudo '

# solve ssh issues in tmux
. ~/bin/ssh-find-agent.bash
