#!/bin/bash
# Generate a useful PS1 for personal use (meant to be sourced from bashrc)
# By anupdhml

# if not a color terminal, set a simple PS1 and exit right away
if [[ "$TERM" != *"color"* ]]; then
  PS1="\u@\h:\w\$ "
  return
fi

__personal_prompt() {
  symbol="$"
  name="\u@\h"

  # colors (dynamic)
  color_name='\[\033[01;35m\]' # pink
  color_path='\[\033[01;34m\]' # blue
  color_git='\[\033[01;30m\]'  # black

  # colors (static)
  COLOR_DANGER='\[\033[01;31m\]' # red
  COLOR_FAILURE='\[\033[0;31m\]' # red (light)
  COLOR_RESET='\[\033[00m\]'

  # configs for __git_ps1 function (sourced from /etc/bash_completion.d/git-prompt)
  GIT_PS1_SHOWUPSTREAM="auto"
  GIT_PS1_SHOWDIRTYSTATE=yes
  #GIT_PS1_SHOWUNTRACKEDFILES=yes
  #GIT_PS1_SHOWSTASHSTATE=yes
  #GIT_PS1_SHOWCOLORHINTS=yes

  # overrides for home user (variations on the name, without the hostname)
  if [ "$USER" = anup ]; then
    name_list=(anup अनुप ανουπ)
    name=${name_list[ RANDOM % ${#name_list[@]} ]}
  fi

  # overrides for production hosts
  if [[ "$HOSTNAME" == *".host."* || "$HOSTNAME" == *".sec."* ]]; then
    color_path="$COLOR_DANGER"
  fi

  # overrides for root user
  if [ "$EUID" -eq 0 ]; then
    symbol="#"
    color_name="$COLOR_DANGER" # red
    color_path="$COLOR_DANGER" # red
  fi

  ##############################################################################

  # for shortening the work path when it gets long
  __shorten_path() {
    local pre= name="$1" length=35;
    [[ "$name" != "${name#$HOME/}" || -z "${name#$HOME}" ]] &&
      pre+='~' name="${name#$HOME}" length=$[length-1];
    ((${#name}>$length)) && name="/...${name:$[${#name}-length+4]}";
    echo "$pre$name"
  }

  _set_ps1() {
    # check the exit code of the previous command and change smileys accordingly
    if [ $? -eq 0 ]; then
      local smiley="|^◡^|"
    else
      local smiley="${COLOR_FAILURE}|T_T|${COLOR_RESET}"
    fi

    local name="${color_name}${name}${COLOR_RESET}"

    local path="${color_path}$(__shorten_path "$PWD")${COLOR_RESET}"

    # escape git info properly since they are dervied from user input
    # prevents security exploits as in https://github.com/njhartwell/pw3nage
    __git_info="$(__git_ps1)"
    local git="${color_git}\${__git_info}${COLOR_RESET}"

    # finally construct the prompt
    PS1="\n${smiley}${name}:${path}${git}${symbol} "
  }

  # function collecting anything else we might want to run.
  # also serves as a placeholder window title for the prompt,
  # since it's executed last.
  ps1() {
    # for syncing history across sessions, every time a command runs
    # disabled because can be expensive over time, and is also prone
    # to bugs (history file gets nuked once in a while)
    #history -a; history -c; history -r;

    : # no-op
  }

  # if the prompt commamd is already set, include it too (stripping of the last
  # ; that may be present).
  # _set_ps1 needs to be at the beginning of the chain here, since we check for
  # the status of the last command in the function.
  PROMPT_COMMAND="_set_ps1${PROMPT_COMMAND:+; ${PROMPT_COMMAND%%;}};ps1"

  ##############################################################################

  # change the window titlebar to show current command
  # https://mg.pov.lt/blog/bash-prompt.html
  # http://www.davidpashley.com/articles/xterm-titles-with-bash.html
  _show_command_in_title_bar() {
    case "$BASH_COMMAND" in
      _*)
        # Ignore commands that begin with _.
        # likely the functions used to set the prompt command.
        ;;
      *\033]0*)
        # The command is trying to set the title bar as well;
        # this is most likely the execution of $PROMPT_COMMAND.
        # In any case nested escapes confuse the terminal, so don't
        # output them.
        ;;
      *)
        #echo -ne "\033]0;${USER}@${HOSTNAME}:$(__shorten_path "$PWD"): ${BASH_COMMAND}\007"
        echo -ne "\033]0;${USER}@${HOSTNAME}: ${BASH_COMMAND}\007"
        ;;
    esac
  }

  trap _show_command_in_title_bar DEBUG
}

__personal_prompt
unset __personal_prompt
