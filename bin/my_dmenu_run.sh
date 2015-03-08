#! /bin/bash
# <http://tools.suckless.org/dmenu/scripts>.

prompt="$USER@`hostname`"
history_path=$HOME/.dmenu_history

function get_commands {
    # Executable exists?
    # <http://stackoverflow.com/questions/592620/how-to-check-if-a-program-exists-from-a-bash-script#677212>.
    if hash stest 2>/dev/null; then
        IFS=:
        stest -flx $PATH
    else
        dmenu_path
    fi
}

killall --quiet dunst &

touch $history_path &&

sed -i -e '$a\' $history_path &&

(
    # (tac $history_path ; stest -flx $PATH | sort -u) \ # reverse order of lines <http://stackoverflow.com/questions/742466/how-can-i-reverse-the-order-of-lines-in-a-file#742485>
    #                                                    # pipe multiple commands to a single command <http://stackoverflow.com/questions/11917708/pipe-multiple-commands-to-a-single-command#11917709>
    #     | awk ' !x[$0]++'                              # removing duplicate lines without sorting <http://stackoverflow.com/questions/11532157/unix-removing-duplicate-lines-without-sorting#11532197>
    (tac $history_path ; get_commands | sort -u) \
        | awk ' !x[$0]++' \
        | dmenu -p $prompt $@
) | tee --append $history_path | ${SHELL:-"/bin/sh"} &
