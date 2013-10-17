# Bash prompt.
ps1_plain="\[\033[0m\]"
ps1_blue="\[\033[01;34m\]"
ps1_green="\[\033[01;32m\]"
ps1_red="\[\033[1;31m\]"
ps1_user="${ps1_green}\u@\h${ps1_plain}"
ps1_dir=" ${ps1_blue}\w${ps1_plain}"
function registr_my_prompt_command() {
    if [ -z "$PROMPT_COMMAND" ]; then
        PROMPT_COMMAND="$1"
    else
        PROMPT_COMMAND=${PROMPT_COMMAND%% }; #remove trailing spaces
        PROMPT_COMMAND=${PROMPT_COMMAND%\;}; #remove trailing semi-colon
        PROMPT_COMMAND="$PROMPT_COMMAND;$1"
    fi
}
# function ps1_set_exit_code {
#     export EXIT_CODE="$?"
# }
# registr_my_prompt_command "ps1_set_exit_code"
# function ps1_exit_code {
#     if [ $EXIT_CODE -ne 0 ]; then
#         echo -n " ${ps1_red}error:${EXIT_CODE}${ps1_plain}"
#     fi
# }
function ps1_jobs {
    if [ `jobs | wc -l` -ne 0 ]; then
        echo -n " ${ps1_red}jobs:\j${ps1_plain}"
    fi
}
function ps1_load {
    # Prompt load average <http://www.gilesorr.com/bashprompt/prompts/load.html>.
    local load_string="$(uptime | sed -e "s/.*load average: \(.*\...\), \(.*\...\), \(.*\...\).*/\1/" -e "s/ //g")"
    local tmp=$(echo ${load_string}*100 | bc)
    let load100=${tmp%.*}
    if [ ${load100} -ge 100 ]; then
        echo -n " ${ps1_red}load:${load_string}${ps1_plain}"
    fi
}
function my_prompt_command {
    PS1="${ps1_user}${ps1_dir}$(ps1_load)$(ps1_jobs)"'$(__git_ps1 " (%s)")\n'"${ps1_blue}\$${ps1_plain} "
}
registr_my_prompt_command "my_prompt_command"
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
registr_my_prompt_command "history -a" #write only
