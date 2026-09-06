#!/usr/bin/env sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

# systemctl daemon-reload
# sudo systemctl enable gitpushmirpub.timer && sudo systemctl enable gitpushmirpvt.timer
# sudo systemctl start  gitpushmirpub.timer && sudo systemctl start  gitpushmirpvt.timer
# systemctl status gitpushmirpub.timer ;  systemctl status gitpushmirpvt.timer

GITPUSHMIRCFGUSAGE="usage: gitpushmir [--repository=\"your.git|your2.git\"] [--mirror=\"github|gitverse\"] [--user=\"\$USER\" ] [ --cron ] [ --force ]"

optflagcheck () { { [ "$1" != "$EOL" ] && [ "$1" != '--' ]; } || { printf >&2 "missing argument %s\n" "$2"; return 2; } } # Avoid infinite loop.

gitpushmircfg () {
    CFG_CRON=-1

    local OPTFLAGEXIT=0
    set -- "$@" "${EOL:=$(printf '\1\3\3\7')}" # End-of-list marker.
    while [ "$1" != "$EOL" ]; do
        local OPTFLAG="$1"; shift

        case "$OPTFLAG" in
            --repository ) optflagcheck "$1" "$OPTFLAG"; OPTFLAGEXIT=$?; CFG_REPOSITORY="$1"; shift;;
            --mirror     ) optflagcheck "$1" "$OPTFLAG"; OPTFLAGEXIT=$?; CFG_MIRROR="$1"; shift;;
            --user       ) optflagcheck "$1" "$OPTFLAG"; OPTFLAGEXIT=$?; CFG_USER="$1"; shift;;
            --cron       ) CFG_CRON=0;;
            --force      ) OPT_FORCE=0;;
            -v | --verbose ) CFG_VERBOSE=0;;
            -h | --help    ) printf "%s\n" "$GITPUSHMIRCFGUSAGE"; exit 0;;

            # Process special cases.
            --) while [ "$1" != "$EOL" ]; do set -- "$@" "$1"; shift; done;;                              # Parse remaining as positional.
            --[!=]*=*) set -- "${OPTFLAG%%=*}" "${OPTFLAG#*=}" "$@";;                                     # "--OPTFLAG=arg"  ->  "--OPTFLAG" "arg"
            -[A-Za-z0-9] | -*[!A-Za-z0-9]*) printf >&2 "unknown option: %s\n" "$OPTFLAG"; OPTFLAGEXIT=2;; # Anything invalid like "-*".
            -?*) other="${OPTFLAG#-?}"; set -- "${OPTFLAG%$other}" "-${other}" "$@";;                     # "-abc"  ->  "-a" "-bc"
            *) set -- "$@" "$OPTFLAG";;                                                                   # Positional, rotate to the end.
        esac

        [ "$OPTFLAGEXIT" != 0 ] && break
    done; shift

    [ "$OPTFLAGEXIT" != 0 ] && printf >&2 "%s\n" "$GITPUSHMIRCFGUSAGE" && exit "$OPTFLAGEXIT"
}

GITPUSHMIRUSAGE="usage: gitpushmir [-d --directory=\"$(eval echo '~git')/your.git\"] [-p --providers=\"github gitverse\"] [-b --branches=\"master your-branch2\" ]"

gitpushmir () {
    OPT_CRON=-1

    local OPTFLAGEXIT=0
    set -- "$@" "${EOL:=$(printf '\1\3\3\7')}" # End-of-list marker.
    while [ "$1" != "$EOL" ]; do
        local OPTFLAG="$1"; shift

        case "$OPTFLAG" in
            -d | --directory ) optflagcheck "$1" "$OPTFLAG"; OPTFLAGEXIT=$?; local OPT_DIRECTORY="$1"; shift;;
            -p | --providers ) optflagcheck "$1" "$OPTFLAG"; OPTFLAGEXIT=$?; local OPT_PROVIDERS="$1"; shift;;
            -b | --branches  ) optflagcheck "$1" "$OPTFLAG"; OPTFLAGEXIT=$?; local OPT_BRANCHES="$1"; shift;;
            -c | --cron      ) OPT_CRON=0;;
            -h | --help      ) printf "%s\n" "$GITPUSHMIRUSAGE"; exit 0;;

            # Process special cases.
            --) while [ "$1" != "$EOL" ]; do set -- "$@" "$1"; shift; done;;                              # Parse remaining as positional.
            --[!=]*=*) set -- "${OPTFLAG%%=*}" "${OPTFLAG#*=}" "$@";;                                     # "--OPTFLAG=arg"  ->  "--OPTFLAG" "arg"
            -[A-Za-z0-9] | -*[!A-Za-z0-9]*) printf >&2 "unknown option: %s\n" "$OPTFLAG"; OPTFLAGEXIT=2;; # Anything invalid like "-*".
            -?*) other="${OPTFLAG#-?}"; set -- "${OPTFLAG%$other}" "-${other}" "$@";;                     # "-abc"  ->  "-a" "-bc"
            *) set -- "$@" "$OPTFLAG";;                                                                   # Positional, rotate to the end.
        esac

        [ "$OPTFLAGEXIT" != 0 ] && break
    done; shift

    [ "$OPTFLAGEXIT" != 0 ] && printf >&2 "%s\n" "$GITPUSHMIRUSAGE" && exit "$OPTFLAGEXIT"

    if [ "$OPT_FORCE" = 0 ] && [ -z "$CFG_REPOSITORY" ] ; then
        printf >&2 "GITPUSHMIR: error: git push force available only with repository regexp\n"
        exit 1
    fi

    local usr

    case "$OPT_DIRECTORY" in
        */danil/* ) usr=danil ;;
        */git/*   ) usr=git ;;
        *) printf >&2 "GITPUSHMIR: error: unknown user for directory %s\n" "$OPT_DIRECTORY"; exit 1 ;;
    esac

    if [ -z "$CFG_USER" ]; then
        sudo cat /dev/null || exit 1
    else
        case "$CFG_USER" in
            danil|git ) ;;
            *) printf >&2 "GITPUSHMIR: error: unknown user for argument %s\n" "$CFG_USER"; exit 1 ;;
        esac

        if [ "$CFG_USER" != "$usr" ]; then
            return 0
        fi
    fi

    local repo_path="${OPT_DIRECTORY#/home/"$usr"/}"
    local repo_path="${repo_path#git/}"
    local repo_name="$(basename "$repo_path")"
    local repo_dir="${repo_path%"$repo_name"}"
    local repo_dir="${repo_dir%/}"
    [ -z "$repo_dir" ] && repo_dir="$usr" || repo_dir="$usr/$repo_dir"

    local kind="interactive"

    if [ "$CFG_CRON" = 0 ]; then
        local kind="batch"

        if [ "$OPT_CRON" = -1 ]; then
            if [ "$CFG_VERBOSE" = 0 ]; then
               printf "GITPUSHMIR: warning: skip interactive repository ~%s %s\n" "$repo_dir" "$repo_name"
            fi

            return 0
        fi
    fi

    if [ -n "$CFG_REPOSITORY" ]; then
        if ! echo "$OPT_DIRECTORY" | egrep --quiet "$CFG_REPOSITORY"; then
            if [ "$CFG_VERBOSE" = 0 ]; then
                printf "GITPUSHMIR: warning: skip masked repository ~%s %s\n" "$repo_dir" "$repo_name"
            fi

            return 0
        fi
    fi

    # <http://stackoverflow.com/questions/1469849/how-to-split-one-string-into-multiple-strings-separated-by-at-least-one-space-in#1469863>,
    # <http://unix.stackexchange.com/questions/47557/in-a-bash-shell-script-writing-a-for-loop-that-iterates-over-string-values#47560>,
    # <http://stackoverflow.com/questions/17249665/splitting-a-comma-separated-string-into-multiple-words-so-that-i-can-loop-throug#17249721>.
    for provider in $OPT_PROVIDERS; do
        if [ -n "$CFG_MIRROR" ]; then
            if ! echo "$provider" | egrep --quiet "$CFG_MIRROR"; then
                if [ "$CFG_VERBOSE" = 0 ]; then
                    printf "GITPUSHMIR: warning: skip masked mirror %s: ~%s %s\n" "$provider" "$repo_dir" "$repo_name"
                fi

                continue
            fi
        fi

        if [ "$OPT_FORCE" = 0 ] ; then
            if [ -z "$CFG_REPOSITORY" ] ; then
                printf >&2 "GITPUSHMIR: error: git force available only with repository regexp\n"
                exit 1
            fi

            printf "GITPUSHMIR: force push %s ~%s %s %s: %s\n" "$repo_dir" "$kind" "$repo_name" "$provider" "$OPT_BRANCHES"
            if [ -z "$CFG_USER" ]; then
                sudo su - "$usr" -c "git -C $OPT_DIRECTORY push --force-with-lease --quiet --tags $provider $OPT_BRANCHES"
            else
                git -C $OPT_DIRECTORY push --force-with-lease --quiet --tags $provider $OPT_BRANCHES
            fi

            continue
        fi

        printf "GITPUSHMIR: %s push ~%s %s %s: %s\n" "$kind" "$repo_dir" "$repo_name" "$provider" "$OPT_BRANCHES"
        if [ -z "$CFG_USER" ]; then
            sudo su - "$usr" -c "git -C $OPT_DIRECTORY push --quiet --tags $provider $OPT_BRANCHES"
        else
            git -C $OPT_DIRECTORY push --quiet --tags $provider $OPT_BRANCHES
        fi
    done
}
