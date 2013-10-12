# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

# Set PATH so it includes user's private bin if it exists.
if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
fi

if [ -d ~/local/bin ] ; then
    PATH=~/local/bin:"${PATH}"
fi

# Tab completion
# <http://en.gentoo-wiki.com/wiki/TAB-Completion#Installation>.
[[ -f /etc/profile.d/bash-completion.sh ]] && source /etc/profile.d/bash-completion.sh

# Disable the XOFF (Ctrl-s) keystroke
# <http://superuser.com/questions/124845/can-you-disable-the-ctrl-s-xoff-keystroke-in-putty#155875>.
stty -ixon

export EDITOR="vim" #export EDITOR="nano" #export EDITOR="/usr/bin/emacsclient -t"
# export ALTERNATE_EDITOR="/usr/bin/emacs"
export PAGER="/usr/bin/less -IM"
export HISTSIZE=10000
export HISTCONTROL=ignoredups
# See /usr/share/terminfo/*/
# export TERM=rxvt-256color
[ "$TERM" = "xterm" ] && TERM="xterm-256color" #<http://ricochen.wordpress.com/2011/07/23/mac-os-x-lion-terminal-color-remote-access-problem-fix>
#export GIT_PAGER=""

# Aliases.
alias less=$PAGER
alias ec='/usr/bin/emacsclient -t'
# alias ecx='/usr/bin/emacsclient --alternate-editor="" -c "$@"'
# Silver searchers colors configurable <https://github.com/ggreer/the_silver_searcher/issues/90>.
alias ag='ag --smart-case --color-line-number "2;31"'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" #load RVM (Ruby Version Manager) into a shell session *as a function* <http://rvm.rvm.io/rvm/install>
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion #RVM bash completion <http://rvm.io/workflow/completion>
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Prompt.
ps1_plain="\[\033[0m\]"
ps1_blue="\[\033[01;34m\]"
ps1_green="\[\033[01;32m\]"
ps1_red="\[\033[1;31m\]"
ps1_user="${ps1_green}\u@\h${ps1_plain}"
ps1_dir=" ${ps1_blue}\w${ps1_plain}"
# Git prompt
# <http://github.com/git/git/blob/master/contrib/completion/git-prompt.sh>.
if [ -f ~/.git-prompt/contrib/completion/git-prompt.sh ]; then
    GIT_PS1_SHOWCOLORHINTS=1
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=1
    GIT_PS1_SHOWUPSTREAM="auto verbose"
    source ~/.git-prompt/contrib/completion/git-prompt.sh
fi
PS1="${ps1_user}${ps1_dir}"'$(__git_ps1 " (%s)")\n'"${ps1_blue}\$${ps1_plain} "
# function prompt_load {
#     # Prompt load average <http://www.gilesorr.com/bashprompt/prompts/load.html>.
#     local load_string="$(uptime | sed -e "s/.*load average: \(.*\...\), \(.*\...\), \(.*\...\).*/\1/" -e "s/ //g")"
#     local tmp=$(echo ${load_string}*100 | bc)
#     let load100=${tmp%.*}
#     if [ ${load100} -ge 100 ]; then
#         echo -n " ${ps1_red}load:${load_string}${ps1_plain}"
#     fi
# }
# function prompt_set_exit_code {
#     export EXIT_CODE="$?"
# }
# registr_prompt_command "prompt_set_exit_code"
# function prompt_exit_code {
#     if [ $EXIT_CODE -ne 0 ]; then
#         echo -n " ${ps1_red}error:${EXIT_CODE}${ps1_plain}"
#     fi
# }
# Prompt last command time
# <http://stackoverflow.com/questions/1862510/how-can-the-last-commands-wall-time-be-put-in-the-bash-prompt#1862762>.
# function prompt_timer_start {
#   PROMPT_TIMER=${PROMPT_TIMER:-$SECONDS}
# }
# function prompt_timer_assign {
#   prompt_timer_seconds=$(($SECONDS - $PROMPT_TIMER))
# }
# function prompt_timer_stop {
#   unset PROMPT_TIMER
# }
# trap 'prompt_timer_start' DEBUG
# function prompt_timer {
#     if [ ${prompt_timer_seconds} -ge 4 ]; then
#         echo -n " ${ps1_plain}time:${prompt_timer_seconds}s"
#     fi
# }
# registr_prompt_command "prompt_timer_assign"
# function prompt_callback {
#     echo -n "${ps1_user}$(prompt_jobs)$(prompt_load)${ps1_dir}"
# }
# registr_prompt_command "prompt_timer_stop"

# History between sessions <http://briancarper.net/blog/248>.
function registr_prompt_command() {
    if [ -z "$PROMPT_COMMAND" ]; then
        PROMPT_COMMAND="$1"
    else
        PROMPT_COMMAND=${PROMPT_COMMAND%% }; #remove trailing spaces
        PROMPT_COMMAND=${PROMPT_COMMAND%\;}; #remove trailing semi-colon
        PROMPT_COMMAND="$PROMPT_COMMAND;$1"
    fi
}
# registr_prompt_command "history -an" #write and read
registr_prompt_command "history -a" #write only

# Lua.
if [ -d ~/.luarocks/bin ] ; then
    PATH=~/.luarocks/bin:"${PATH}"
fi
export LUA_PATH="/home/danil/.luarocks/share/lua/5.1//?.lua;./?.lua;$LUA_PATH"
export LUA_CPATH="/home/danil/.luarocks/lib/lua/5.1//?.so;./?.so;$LUA_CPATH"
#export LUA_INIT="require 'luarocks.require'"

# Node.js
export NODE_PATH="$HOME/local:$HOME/local/lib/node_modules"
if [ -d ~/node_modules/.bin ] ; then
    PATH=~/node_modules/.bin:"${PATH}"
fi
