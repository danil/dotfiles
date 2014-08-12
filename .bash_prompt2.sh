# Bash prompt.
# Colors
# Below are the color init strings for the basic file types. A color init
# string consists of one or more of the following numeric codes:
# Attribute codes:
# 00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed
# Text color codes:
# 30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
# Background color codes:
# 40=black 41=red 42=green 43=yellow 44=blue 45=magenta 46=cyan 47=white
# <https://wiki.archlinux.org/index.php/Color_Bash_Prompt#.2Fetc.2FDIR_COLORS>.
ps1_plain="\[\033[0m\]"
ps1_blue="\[\033[01;34m\]"
ps1_cyan="\[\033[1;36m\]"
ps1_green="\[\033[01;32m\]"
ps1_magenta="\[\033[1;35m\]"
ps1_red="\[\033[1;31m\]"
ps1_user="${ps1_green}\u@\h${ps1_plain}"
ps1_pwd=" ${ps1_blue}\w${ps1_plain}"
function registr_my_prompt_command() {
    if [ -z "$PROMPT_COMMAND" ]; then
        PROMPT_COMMAND="$1"
    else
        PROMPT_COMMAND=${PROMPT_COMMAND%% }; #remove trailing spaces
        PROMPT_COMMAND=${PROMPT_COMMAND%\;}; #remove trailing semi-colon
        PROMPT_COMMAND="$PROMPT_COMMAND;$1"
    fi
}
function ps1_jobs {
    jobs_count=`jobs | wc -l`
    if [ ${jobs_count} -ne 0 ]; then
        # echo -n " ${ps1_red}jobs:\j${ps1_plain}"
        echo -n " jobs:${jobs_count}"
    fi
}
function ps1_pwd {
  local my_pwd=$(echo $PWD | sed -e "s|^$HOME|~|" -e 's-\([^/.]\)[^/]*/-\1/-g')
  echo -n " ${ps1_blue}${my_pwd}${ps1_plain}"
}
function ps1_load {
    # Prompt load average
    # <http://www.gilesorr.com/bashprompt/prompts/load.html>,
    # <http://stackoverflow.com/questions/1738665/showing-only-the-uptime-from-uptime-unix/1738675#1740333>.
    local load_string="$(uptime)"
    local load_string=${load_string/#*average: }
    local load_string=${load_string%%,*}
    local tmp=$(echo ${load_string}*100 | bc)
    let load100=${tmp%.*}
    # if [[ ${load100} -ge 100 ]]; then
    if [[ ${load100} -ge 30 ]]; then
        # echo -n " ${ps1_red}load:${load_string}${ps1_plain}"
        echo -n " load:${load_string}"
    fi
}
function my_ps1_timer_start {
    my_ps1_timer=${my_ps1_timer:-$SECONDS}
}
function my_ps1_timer_show {
    local tmp=$(($SECONDS - $my_ps1_timer))
    let timer=${tmp}
    if [[ ${timer} -ge 1 ]]; then
        # cmd1 &
        # cmd1_pid=$!
        # sleep 10
        # cmd2
        # sleep 10
        # cmd2
        # wait $cmd1_pid
        playsuccess &
        echo -n " time:"$(($SECONDS - $my_ps1_timer))
    fi
}
# Assign PS1 dynamically
# <http://stackoverflow.com/questions/3058325/what-is-the-difference-between-ps1-and-prompt-command#3058390>.
function my_ps1_assign_variables {
    # Exit status error
    # <http://brettterpstra.com/2009/11/17/my-new-favorite-bash-prompt>.
    exit_code=$?
    if [[ $exit_code -eq 0 || $exit_code -ge 128 ]]; then #set an error string for the prompt, if applicable (ignore kill e. g. 130 script terminated by control-c <http://www.tldp.org/LDP/abs/html/exitcodes.html>)
        ps1_exit_code=""
    else
        # ps1_exit_code=" ${ps1_red}error:$exit_code$ps1_plain"
        ps1_exit_code=" error:$exit_code"
    fi
    ps1_load="$(ps1_load)"
    ps1_jobs="$(ps1_jobs)"

    # # Prompt unicode arrow
    # # <http://crunchbang.org/forums/viewtopic.php?pid=127747#p127747>,
    # # <https://wiki.archlinux.org/index.php/Color_Bash_Prompt#From_Arch_Forum_.231>.
    # PS1="${ps1_user}${ps1_exit_code}$(ps1_load)$(ps1_jobs)${ps1_pwd}${ps1_magenta}"'$(__git_ps1 " %s")'"\n${ps1_cyan}\$${ps1_plain} "

    my_ps1_timer_show="$(my_ps1_timer_show)"
    unset my_ps1_timer
}
trap 'my_ps1_timer_start' DEBUG
PROMPT_COMMAND=my_ps1_assign_variables
PS1="${ps1_user}"
PS1+="${ps1_red}"'${my_ps1_timer_show}'
PS1+='${ps1_exit_code}'
PS1+='${ps1_load}'
PS1+='${ps1_jobs}'
PS1+="${ps1_pwd}"
PS1+="${ps1_magenta}"'$(__git_ps1 " %s")'
PS1+="\n${ps1_cyan}\$${ps1_plain} "
# Git prompt
# <http://github.com/git/git/blob/master/contrib/completion/git-prompt.sh>.
if [ -f ~/.git-prompt/contrib/completion/git-prompt.sh ]; then
    GIT_PS1_SHOWCOLORHINTS=1
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=1
    GIT_PS1_SHOWUPSTREAM="auto"
    source ~/.git-prompt/contrib/completion/git-prompt.sh
fi
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
# registr_my_prompt_command "prompt_timer_assign"
# function prompt_callback {
#     echo -n "${ps1_user}$(prompt_jobs)$(prompt_load)${ps1_dir}"
# }
# registr_my_prompt_command "prompt_timer_stop"

# History between sessions <http://briancarper.net/blog/248>.
# registr_my_prompt_command "history -an" #write and read
# registr_my_prompt_command "history -a" #write only
