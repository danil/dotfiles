#!/usr/bin/env sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

log=/var/log/gitpushmirror.log

gitpush () {
    local dir=$1
    local vendors=$2
    local branches=$3

    sudo cat /dev/null || exit 1

    # <http://stackoverflow.com/questions/1469849/how-to-split-one-string-into-multiple-strings-separated-by-at-least-one-space-in#1469863>,
    # <http://unix.stackexchange.com/questions/47557/in-a-bash-shell-script-writing-a-for-loop-that-iterates-over-string-values#47560>,
    # <http://stackoverflow.com/questions/17249665/splitting-a-comma-separated-string-into-multiple-words-so-that-i-can-loop-throug#17249721>.
    for vendor in $vendors; do
        if printf "%s" "$UNI_CLI" | grep -q "^[[:space:]]*sudo[[:space:]]"; then
            sudo cat /dev/null || exit 1
        fi

        local usr

        case "$dir" in
            */danil/* ) usr=danil ;;
            */git/*   ) usr=git ;;
            *) printf >&2 "GITPUSHMIRROR: error: unknown user for directory %s\n" "$dir"; exit 1 ;;
        esac

        cmd="git -C "$dir" push --quiet --tags $vendor $branches"
        repo_path="${dir#/home/"$usr"/}"
        repo_path="${repo_path#git/}"
        repo_name="$(basename "$repo_path")"
        repo_dir="${repo_path%"$repo_name"}"
        repo_dir="${repo_dir%/}"
        [ -z "$repo_dir" ] && repo_dir="$usr" || repo_dir="$usr/$repo_dir"

        echo "$(date --utc '+%d/%I/%Y %H:%M:%S') ~$repo_dir $repo_name $vendor: $branches" >>$log 2>&1

        sudo -u "$usr" bash -c "$cmd >>$log 2>&1"
    done
}
