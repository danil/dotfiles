#!/bin/sh
# <http://tools.suckless.org/dmenu/scripts>.

font="Monospace-12"
prompt="$USER@`hostname`"
foreground="white"
background="black"
selected_foreground="black"
selected_background="OrangeRed1"
dmenu_history=$HOME/.dmenu_history

touch $dmenu_history

# Adds \n at the end of the file only if it doesn’t already end with a newline
# <http://unix.stackexchange.com/questions/31947/how-to-add-a-newline-to-the-end-of-a-file#31955>.
sed -i '' -e '$a\' $dmenu_history

# Executable exists?
# <http://stackoverflow.com/questions/592620/how-to-check-if-a-program-exists-from-a-bash-script#677212>.
if hash dmenu_path 2>/dev/null; then
    (
        (tac $dmenu_history ; dmenu_path | sort -u) \
            | awk ' !x[$0]++' \
            | dmenu -fn $font -p $prompt \
            -nf $foreground -nb $background \
            -sf $selected_foreground -sb $selected_background $@
    ) | tee --append "$dmenu_history" | ${SHELL:-"/bin/sh"} &
else
    (
        IFS=:
        # (tac $dmenu_history ; stest -flx $PATH | sort -u) \ # reverse order of lines <http://stackoverflow.com/questions/742466/how-can-i-reverse-the-order-of-lines-in-a-file#742485>
        #                                                     # pipe multiple commands to a single command <http://stackoverflow.com/questions/11917708/pipe-multiple-commands-to-a-single-command#11917709>
        #     | awk ' !x[$0]++'                               # removing duplicate lines without sorting <http://stackoverflow.com/questions/11532157/unix-removing-duplicate-lines-without-sorting#11532197>
        (tac $dmenu_history ; stest -flx $PATH | sort -u) \
            | awk ' !x[$0]++' \
            | dmenu -fn $font -p $prompt \
            -nf $foreground -nb $background \
            -sf $selected_foreground -sb $selected_background $@
    ) | tee --append "$dmenu_history" | ${SHELL:-"/bin/sh"} &
fi
