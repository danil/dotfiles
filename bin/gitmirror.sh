#!/usr/bin/env sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

log=/var/log/gitmirror.log

gitmirror () {
    local folder=$1
    local vendors=$2
    local branches=$3
    cd "$folder"
    # <http://stackoverflow.com/questions/1469849/how-to-split-one-string-into-multiple-strings-separated-by-at-least-one-space-in#1469863>,
    # <http://unix.stackexchange.com/questions/47557/in-a-bash-shell-script-writing-a-for-loop-that-iterates-over-string-values#47560>,
    # <http://stackoverflow.com/questions/17249665/splitting-a-comma-separated-string-into-multiple-words-so-that-i-can-loop-throug#17249721>.
    for vendor in $vendors; do
        echo "$(date --utc '+%d/%I/%Y %H:%M:%S') $folder $vendor: $branches" >>$log 2>&1
        git push --quiet --tags $vendor $branches >>$log 2>&1
    done
}
