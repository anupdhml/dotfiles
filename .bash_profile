# My .bash_profile

#clear

# dark colors
#NONE='\[\033[0m\]'    # unsets color to term's fg color

#DK='\[\033[0;30m\]'    # black
#DR='\[\033[0;31m\]'    # red
#DG='\[\033[0;32m\]'    # green
#DY='\[\033[0;33m\]'    # yellow
#DB='\[\033[0;34m\]'    # blue
#DM='\[\033[0;35m\]'    # magenta
#DC='\[\033[0;36m\]'    # cyan
#DW='\[\033[0;37m\]'    # white

## light colors
#LK='\[\033[1;30m\]'    # black
#LR='\[\033[1;31m\]'    # red
#LG='\[\033[1;32m\]'    # green
#LY='\[\033[1;33m\]'    # yellow
#LB='\[\033[1;34m\]'    # blue
#LM='\[\033[1;35m\]'    # magenta
#LC='\[\033[1;36m\]'    # cyan
#LW='\[\033[1;37m\]'    # white

## inverted dark colors
#IDK='\[\033[0;40m\]'    # black
#IDR='\[\033[0;41m\]'    # red
#IDG='\[\033[0;42m\]'    # green
#IDY='\[\033[0;43m\]'    # yellow
#IDB='\[\033[0;44m\]'    # blue
#IDM='\[\033[0;45m\]'    # magenta
#IDC='\[\033[0;46m\]'    # cyan
#IDW='\[\033[0;47m\]'    # white

## inverted light colors
#ILK='\[\033[1;40m\]'    # black
#ILR='\[\033[1;41m\]'    # red
#ILG='\[\033[1;42m\]'    # green
#ILY='\[\033[1;43m\]'    # yellow
#ILB='\[\033[1;44m\]'    # blue
#ILM='\[\033[1;45m\]'    # magenta
#ILC='\[\033[1;46m\]'    # cyan
#ILW='\[\033[1;47m\]'    # white

# Linux console colors (jwr dark) 
#if [ "$TERM" = "linux" ]; then
   #echo -en "\e]P0000000" #black
   #echo -en "\e]P83d3d3d" #darkgrey
   #echo -en "\e]P18c4665" #darkred
   #echo -en "\e]P9bf4d80" #red
   #echo -en "\e]P2287373" #darkgreen
   #echo -en "\e]PA53a6a6" #green
   #echo -en "\e]P37c7c99" #brown
   #echo -en "\e]PB9e9ecb" #yellow
   #echo -en "\e]P4395573" #darkblue
   #echo -en "\e]PC477ab3" #blue
   #echo -en "\e]P55e468c" #darkmagenta
   #echo -en "\e]PD7e62b3" #magenta
   #echo -en "\e]P631658c" #darkcyan
   #echo -en "\e]PE6096bf" #cyan
   #echo -en "\e]P7899ca1" #lightgrey
   #echo -en "\e]PFc0c0c0" #white
   #clear # bring us back to default input colours
#fi

# Linux console colors. Matrix theme in tty1
# scale factor 4
# http://www.javascriptsource.com/miscellaneous/true-color-darkening-and-lightening.html
if [ $(tty) == /dev/tty1 ] ; then 
    c0=121212 #background black
    c8=3b3b3b 
    c1=113311 #string red
    c9=387f38
    c2=55ff55 #type green
    cA=aaffaa 
    c3=55ff55 #statement yellow
    cB=aaffaa
    c4=44cc44 #identifier blue
    cC=97f097 
    c5=44cc44 #special magenta
    cD=97f097
    c6=226622 #comment cyan
    cE=61b961
    c7=339933 #cursorline white
    cF=7fda7f
else                            
    #c0=EEEEEC #white
    #c8=D6D6D6 #lightgrey
    #c0=000000 #black
    #c0=2E3436 #black
    c0=121212 #black
    c8=6C6C6C #darkgrey

    c1=CC0000 #darkred
    c9=EF2929 #red

    c2=4E9A06 #darkgreen
    cA=8AE234 #green
    #c2=339933 #matrix green
    #cA=7fda7f

    c3=C4A000 #brown
    cB=FCE94F #yellow
    c4=3465A4 #darkblue
    cC=729FCF #blue
    c5=75507B #darkmagenta
    cD=AD7FA8 #magenta
    c6=06989A #darkcyan
    cE=34E2E2 #cyan

    #c7=6C6C6C #darkgrey
    #cF=000000 #black
    #cF=2E3436 #black
    c7=D6D6D6 #lightgrey
    cF=EEEEEC #white
fi

# setup colors
#if [ -z "$DISPLAY" ] && [ $(tty) != /dev/tty6 ] ; then
#if [ "$TERM" = "linux" ] && [ $(tty) != /dev/tty6 ]; then
    #echo -en "\e]P0$c0" #black
    #echo -en "\e]P8$c8" #darkgrey
    #echo -en "\e]P1$c1" #darkred
    #echo -en "\e]P9$c9" #red
    #echo -en "\e]P2$c2" #darkgreen
    #echo -en "\e]PA$cA" #green
    #echo -en "\e]P3$c3" #brown
    #echo -en "\e]PB$cB" #yellow
    #echo -en "\e]P4$c4" #darkblue
    #echo -en "\e]PC$cC" #blue
    #echo -en "\e]P5$c5" #darkmagenta
    #echo -en "\e]PD$cD" #magenta
    #echo -en "\e]P6$c6" #darkcyan
    #echo -en "\e]PE$cE" #cyan
    #echo -en "\e]P7$c7" #lightgrey
    #echo -en "\e]PF$cF" #white
    ##clear # bring us back to default input colours
#fi

# set PATH so it includes user's private bin if it exists
#if [ -d "$HOME/bin" ] ; then
    #PATH="$HOME/bin:$PATH"
#fi

# haskell stuff
PATH="$HOME/.cabal/bin:$PATH"

# vi all the way
EDITOR="vi"

export TTY=$(tty) 

## byobu launch for tty1 and tty2 only
#if [ -z "$DISPLAY" ] && [ $(tty) == /dev/tty1 -o $(tty) == /dev/tty2 ] ; then
##if [ -z "$DISPLAY" ] ; then
    #`echo $- | grep -qs i` && which byobu-launcher > /dev/null && byobu-launcher
#fi

# TMUX ALTERNATE
#if which tmux 2>&1 >/dev/null; then
    ## if no session is started, start a new session
    #test -z ${TMUX} && tmux

    ## when quitting tmux, try to attach
    #while test -z ${TMUX}; do
        #tmux attach || break
    #done
#fi

# TMUX for tty2 and tty3
if [ -z "$DISPLAY" ] && [ $(tty) == /dev/tty2 -o $(tty) == /dev/tty3 ] ; then
    # If not running interactively, do not do anything
    [[ $- != *i* ]] && return
    [[ $TERM != "screen" ]] && tmux && exit
fi

# for tmux and tty combination
if ( w | grep tty1 | grep tmux > /dev/null); then
  export TMUXINTTY=1
else
  export TMUXINTTY=0
fi

## migrated to inputrc
## migrated from .bash_profile. For some reason, gave problems there.
# make history search easier..
#bind '"\e[A"':history-search-backward
#bind '"\e[B"':history-search-forward

## migrated from .bash_profile. For some reason, gave problems there.
# Make man pages colorful, when using less
#if [ $TERM == linux ] && [ $(tty) == /dev/tty1 ] ; then
if ( [ $TERM == linux ] && [ $(tty) == /dev/tty1 ] ) || [ $TMUXINTTY  == 1 ]; then
  echo -n ""
  #export LESS_TERMCAP_ue=$'\E[0m'          # end underline
  #export LESS_TERMCAP_us=$'\E[1;32m'      # begin underline green
else
  export LESS_TERMCAP_mb=$'\E[0;31m'      # begin blinking red
  export LESS_TERMCAP_md=$'\E[0;31m'      # begin bold red
  export LESS_TERMCAP_me=$'\E[0m'          # end mode
  export LESS_TERMCAP_se=$'\E[0m'          # end standout-mode                 
  export LESS_TERMCAP_so=$'\E[1;44;33m'   # begin standout-mode - info box yellow                             
  export LESS_TERMCAP_ue=$'\E[0m'          # end underline
  export LESS_TERMCAP_us=$'\E[0;32m'      # begin underline green
fi

export VISUAL="/usr/bin/vim"

#export COWPATH="/usr/share/cowsay/cows:$HOME/data/cows/my_cows:$HOME/data/cows/other_cows"
COW_BASE_DIR=$HOME/data/cows
export COWPATH="$COW_BASE_DIR/my_cows:$COW_BASE_DIR/other_cows:$COW_BASE_DIR/aur_cows:$COW_BASE_DIR/ubuntu_cows"

# source the bashrc file
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

# for drush, drupal
#export PATH="$HOME/.composer/vendor/bin:$PATH"
#if [ -f $HOME/.composer/vendor/drush/drush/examples/example.bashrc ] ; then
  #. $HOME/.composer/vendor/drush/drush/examples/example.bashrc
#fi
#if [ -f $HOME/.composer/vendor/drush/drush/drush.complete.sh ] ; then
  #. $HOME/.composer/vendor/drush/drush/drush.complete.sh
#fi

# ssh agent

# Note: ~/.ssh/environment should not be used, as it
#       already has a different purpose in SSH.

env=~/.ssh/agent.env

# Note: Don't bother checking SSH_AGENT_PID. It's not used
#       by SSH itself, and it might even be incorrect
#       (for example, when using agent-forwarding over SSH).

agent_is_running() {
    if [ "$SSH_AUTH_SOCK" ]; then
        # ssh-add returns:
        #   0 = agent running, has keys
        #   1 = agent running, no keys
        #   2 = agent not running
        ssh-add -l >/dev/null 2>&1 || [ $? -eq 1 ]
    else
        false
    fi
}

agent_has_keys() {
    ssh-add -l >/dev/null 2>&1
}

agent_load_env() {
    . "$env" >/dev/null
}

agent_start() {
    (umask 077; ssh-agent >"$env")
    . "$env" >/dev/null
}

if ! agent_is_running; then
    agent_load_env
fi

# if your keys are not stored in ~/.ssh/id_rsa or ~/.ssh/id_dsa, you'll need
# to paste the proper path after ssh-add
if ! agent_is_running; then
    agent_start
    ssh-add
elif ! agent_has_keys; then
    ssh-add
fi

unset env
