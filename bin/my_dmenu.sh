#!/bin/sh
dmenu_history=$HOME/.dmenu_history
touch $dmenu_history
(
    IFS=:
    # (tac $dmenu_history ; stest -flx $PATH | sort -u) \ # reverse order of lines <http://stackoverflow.com/questions/742466/how-can-i-reverse-the-order-of-lines-in-a-file#742485>
    #                                                     # pipe multiple commands to a single command <http://stackoverflow.com/questions/11917708/pipe-multiple-commands-to-a-single-command#11917709>
    #     | awk ' !x[$0]++'                               # removing duplicate lines without sorting <http://stackoverflow.com/questions/11532157/unix-removing-duplicate-lines-without-sorting#11532197>
    (tac $dmenu_history ; stest -flx $PATH | sort -u) \
        | awk ' !x[$0]++' \
        | dmenu "$@"
) | tee --append "$dmenu_history" | ${SHELL:-"/bin/sh"} &
