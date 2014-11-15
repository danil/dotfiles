# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

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
# <https://wiki.archlinux.org/index.php/Color_Bash_Prompt#List_of_colors_for_prompt_and_Bash>
# <http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html>.
ps1_blue="\[\033[01;34m\]"
ps1_cyan="\[\033[1;36m\]"
ps1_green="\[\033[01;32m\]"
ps1_magenta="\[\033[1;35m\]"
ps1_plain="\[\033[0m\]"
ps1_red="\[\033[1;31m\]"
ps1_white="\[\033[1;37m\]"
ps1_yellow="\[\033[1;33m\]"

ps1_user="${ps1_green}\u@\h${ps1_plain}"
ps1_pwd=" ${ps1_blue}\w${ps1_plain}"
function ps1_jobs {
    jobs_count=`jobs | wc -l`
    if [ ${jobs_count} -ne 0 ]; then
        echo -n " jobs:${jobs_count}"
    fi
}
function ps1_pwd {
  local my_pwd=$(echo $PWD \
      | sed --expression="s|^$HOME|~|" --expression='s-\([^/.]\)[^/]*/-\1/-g')
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
    if [[ ${load100} -ge 100 ]]; then
        echo -n " load:${load_string}"
    fi
}
function ps1_outdated_packages {
    local outdated_string="$(cat /etc/portage/package.outdated)"
    if [[ ${outdated_string} -gt 0 ]]; then
        echo -n " outdated:${outdated_string}"
    fi
}
function my_ps1_timer_start {
    my_ps1_timer_seconds=${my_ps1_timer_seconds:-$SECONDS}
}
function my_ps1_timer_show {
    local tmp=$(($SECONDS - $my_ps1_timer_seconds))
    let timer=${tmp}
    if [[ ${timer} -ge 10 ]]; then
        if command -v play >/dev/null 2>&1 && #how to check if a program exists <http://stackoverflow.com/questions/592620/how-to-check-if-a-program-exists-from-a-bash-script#677212>
            [ -f /home/danil/local/share/sounds/complete.oga ]; then
            # <http://en.wikipedia.org/wiki/Nohup#Overcoming_hanging>.
            nohup play -q --no-show-progress \
                /home/danil/local/share/sounds/complete.oga \
                > /dev/null 2> /dev/null < /dev/null &
        fi
        if notify-send -v play >/dev/null 2>&1 ; then
            notify_title="time:$timer"
            if [[ ${my_exit_code} -eq 0 ]]; then
                #low, normal, critical
                my_notify_urgency="normal"
            else
                my_notify_urgency="critical"
                notify_title="exit:$my_exit_code $notify_title"
            fi
            notify-send --urgency=$my_notify_urgency \
                "$notify_title" \
                "$my_previous_command"
        fi
        echo -n " time:$timer"
    fi
}
if [ -f ~/.git-prompt/contrib/completion/git-prompt.sh ]; then
    # Git prompt
    # <http://github.com/git/git/blob/master/contrib/completion/git-prompt.sh>.
    GIT_PS1_SHOWCOLORHINTS=1
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=1
    GIT_PS1_SHOWUPSTREAM="auto"
    source ~/.git-prompt/contrib/completion/git-prompt.sh
fi
function my_ps1_dynamic_variables {
    my_exit_code=$? #exit status error <http://brettterpstra.com/2009/11/17/my-new-favorite-bash-prompt>
    if [[ $my_exit_code -eq 0 || $my_exit_code -ge 128 ]]; then #set an error string for the prompt, if applicable (ignore kill e. g. 130 script terminated by control-c <http://www.tldp.org/LDP/abs/html/exitcodes.html>)
        ps1_exit_code=""
    else
        ps1_exit_code=" error:$my_exit_code"
    fi

    ps1_load="$(ps1_load)"
    ps1_jobs="$(ps1_jobs)"
    ps1_outdated_packages="$(ps1_outdated_packages)"

    # History between sessions <http://briancarper.net/blog/248>.
    # history -an #write and read
    history -a #write only

    my_ps1_timer_show="$(my_ps1_timer_show)"
    unset my_ps1_timer_seconds
}
my_trap='my_ps1_timer_start;'
my_trap+='my_previous_command=$my_current_command; my_current_command=$BASH_COMMAND' #echo last command <http://stackoverflow.com/questions/6109225/bash-echoing-the-last-command-run#6110446>.
trap "$my_trap" DEBUG
PROMPT_COMMAND=my_ps1_dynamic_variables #assign PS1 variables dynamically <http://stackoverflow.com/questions/3058325/what-is-the-difference-between-ps1-and-prompt-command#3058390>
PS1="${ps1_user}"
PS1+="${ps1_red}"
PS1+='${ps1_exit_code}'
PS1+='${ps1_load}'
PS1+="${ps1_yellow}"
PS1+='${my_ps1_timer_show}' #prompt last command time <http://stackoverflow.com/questions/1862510/how-can-the-last-commands-wall-time-be-put-in-the-bash-prompt#1862762>
PS1+="${ps1_white}"
PS1+='${ps1_outdated_packages}'
PS1+='${ps1_jobs}'
PS1+="${ps1_pwd}"
PS1+="${ps1_magenta}"'$(__git_ps1 " %s")'
PS1+="\n"
PS1+="${ps1_cyan}\$${ps1_plain} "
