#!/usr/bin/env sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

GITPUSHMIRRORUSAGE="usage: gitpushmirror [--repository=\"your.git|your2.git\"] [--mirror=\"github|gitverse\"]"

gitpushmconfig () {
    local OPTFLAGEXIT=0
    set -- "$@" "${EOL:=$(printf '\1\3\3\7')}" # End-of-list marker.
    while [ "$1" != "$EOL" ]; do
        local OPTFLAG="$1"; shift

        case "$OPTFLAG" in
            --repository ) optflagcheck "$1" "$OPTFLAG"; OPTFLAGEXIT=$?; OPT_REPOSITORY="$1"; shift;;
            --mirror     ) optflagcheck "$1" "$OPTFLAG"; OPTFLAGEXIT=$?; OPT_MIRROR="$1"; shift;;
            --user       ) optflagcheck "$1" "$OPTFLAG"; OPTFLAGEXIT=$?; OPT_USER="$1"; shift;;
            --force      ) OPT_FORCE=0;;
            -h | --help    ) printf "%s\n" "$GITPUSHMIRRORUSAGE"; exit 0;;

            # Process special cases.
            --) while [ "$1" != "$EOL" ]; do set -- "$@" "$1"; shift; done;;                              # Parse remaining as positional.
            --[!=]*=*) set -- "${OPTFLAG%%=*}" "${OPTFLAG#*=}" "$@";;                                     # "--OPTFLAG=arg"  ->  "--OPTFLAG" "arg"
            -[A-Za-z0-9] | -*[!A-Za-z0-9]*) printf >&2 "unknown option: %s\n" "$OPTFLAG"; OPTFLAGEXIT=2;; # Anything invalid like "-*".
            -?*) other="${OPTFLAG#-?}"; set -- "${OPTFLAG%$other}" "-${other}" "$@";;                     # "-abc"  ->  "-a" "-bc"
            *) set -- "$@" "$OPTFLAG";;                                                                   # Positional, rotate to the end.
        esac

        [ "$OPTFLAGEXIT" != 0 ] && break
    done; shift

    [ "$OPTFLAGEXIT" != 0 ] && printf >&2 "%s\n" "$GITPUSHMIRRORUSAGE" && exit "$OPTFLAGEXIT"
}

optflagcheck () { { [ "$1" != "$EOL" ] && [ "$1" != '--' ]; } || { printf >&2 "missing argument %s\n" "$2"; return 2; } } # Avoid infinite loop.

gitpushm () {
    if [ "$OPT_FORCE" = 0 ] && [ -z "$OPT_REPOSITORY" ] ; then
        printf >&2 "GITPUSHMIRROR: error: git push force available only with repository regexp\n"
        exit 1
    fi

    local dir=$1
    local vendors=$2
    local branches=$3

    local usr

    case "$dir" in
        */danil/* ) usr=danil ;;
        */git/*   ) usr=git ;;
        *) printf >&2 "GITPUSHMIRROR: error: unknown user for directory %s\n" "$dir"; exit 1 ;;
    esac

    if [ -z "$OPT_USER" ]; then
        sudo cat /dev/null || exit 1
    else
        case "$OPT_USER" in
            danil|git ) ;;
            *) printf >&2 "GITPUSHMIRROR: error: unknown user for argument %s\n" "$OPT_USER"; exit 1 ;;
        esac

        if [ "$OPT_USER" != "$usr" ]; then
            return 0
        fi
    fi

    local repo_path="${dir#/home/"$usr"/}"
    local repo_path="${repo_path#git/}"
    local repo_name="$(basename "$repo_path")"
    local repo_dir="${repo_path%"$repo_name"}"
    local repo_dir="${repo_dir%/}"
    [ -z "$repo_dir" ] && repo_dir="$usr" || repo_dir="$usr/$repo_dir"

    if [ -n "$OPT_REPOSITORY" ]; then
        if ! echo "$dir" | egrep --quiet "$OPT_REPOSITORY"; then
            printf "GITPUSHMIRROR: warning: skipping repository ~%s %s\n" "$repo_dir" "$repo_name"
            return 0
        fi
    fi

    # <http://stackoverflow.com/questions/1469849/how-to-split-one-string-into-multiple-strings-separated-by-at-least-one-space-in#1469863>,
    # <http://unix.stackexchange.com/questions/47557/in-a-bash-shell-script-writing-a-for-loop-that-iterates-over-string-values#47560>,
    # <http://stackoverflow.com/questions/17249665/splitting-a-comma-separated-string-into-multiple-words-so-that-i-can-loop-throug#17249721>.
    for vendor in $vendors; do
        if [ -n "$OPT_MIRROR" ]; then
            if ! echo "$vendor" | egrep --quiet "$OPT_MIRROR"; then
                printf "GITPUSHMIRROR: warning: skipping mirror %s: ~%s %s\n" "$vendor" "$repo_dir" "$repo_name"
                continue
            fi
        fi

        if [ "$OPT_FORCE" = 0 ] ; then
            if [ -z "$OPT_REPOSITORY" ] ; then
                printf >&2 "GITPUSHMIRROR: error: git force available only with repository regexp\n"
                exit 1
            fi

            printf "GITPUSHMIRROR: force ~%s %s %s: %s\n" "$repo_dir" "$repo_name" "$vendor" "$branches"
            if [ -z "$OPT_USER" ]; then
                sudo su - "$usr" -c "git -C $dir push --force-with-lease --quiet --tags $vendor $branches"
            else
                git -C $dir push --force-with-lease --quiet --tags $vendor $branches
            fi

            continue
        fi

        printf "GITPUSHMIRROR: push ~%s %s %s: %s\n" "$repo_dir" "$repo_name" "$vendor" "$branches"
        if [ -z "$OPT_USER" ]; then
            sudo su - "$usr" -c "git -C $dir push --quiet --tags $vendor $branches"
        else
            git -C $dir push --quiet --tags $vendor $branches
        fi
    done
}
