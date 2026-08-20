#!/usr/bin/env sh

GITBUNDLEARCHIVE_USAGE="usage: gitbundlearchive.sh --in=your/dir --out=your/dir2"

gitbundlearchive () {
    local OPT_IN_PATH=""
    local OPT_OUT_PATH=""

    local OPTFLAGEXIT=0
    set -- "$@" "${EOL:=$(printf '\1\3\3\7')}" # End-of-list marker.
    while [ "$1" != "$EOL" ]; do
        local OPTFLAG="$1"; shift

        case "$OPTFLAG" in
            --in  ) optflagcheck "$1" "$OPTFLAG"; OPTFLAGEXIT=$?; local OPT_IN_PATH="$1"; shift;;
            --out ) optflagcheck "$1" "$OPTFLAG"; OPTFLAGEXIT=$?; local OPT_OUT_PATH="$1"; shift;;
            -h | --help  ) printf "%s\n" "$GITBUNDLEARCHIVE_USAGE"; exit 0;;

            # Process special cases.
            --) while [ "$1" != "$EOL" ]; do set -- "$@" "$1"; shift; done;;                              # Parse remaining as positional.
            --[!=]*=*) set -- "${OPTFLAG%%=*}" "${OPTFLAG#*=}" "$@";;                                     # "--OPTFLAG=arg"  ->  "--OPTFLAG" "arg"
            -[A-Za-z0-9] | -*[!A-Za-z0-9]*) printf >&2 "unknown option: %s\n" "$OPTFLAG"; OPTFLAGEXIT=2;; # Anything invalid like "-*".
            -?*) other="${OPTFLAG#-?}"; set -- "${OPTFLAG%$other}" "-${other}" "$@";;                     # "-abc"  ->  "-a" "-bc"
            *) set -- "$@" "$OPTFLAG";;                                                                   # Positional, rotate to the end.
        esac

        [ "$OPTFLAGEXIT" != 0 ] && break
    done; shift


    [ "$OPTFLAGEXIT" != 0 ] && printf >&2 "%s\n" "$GITBUNDLEARCHIVE_USAGE" && exit "$OPTFLAGEXIT"

    if [ -z "$OPT_IN_PATH" ]; then
      printf >&2 "error: missing path to input directory\n" && printf >&2 "%s\n" "$GITBUNDLEARCHIVE_USAGE" && exit 2
      exit 1
    fi

    if [ ! -d "$OPT_IN_PATH" ]; then
        printf >&2 "error: intput directory does not exist\n" && printf >&2 "%s\n" "$GITBUNDLEARCHIVE_USAGE" && exit 2
        exit 1
    fi

    OPT_IN_PATH=$(readlink -f "$OPT_IN_PATH")

    if [ -z "$OPT_OUT_PATH" ]; then
        printf >&2 "error: missing path to output directory\n" && printf >&2 "%s\n" "$GITBUNDLEARCHIVE_USAGE" && exit 2
        exit 1
    fi

    if [ ! -d "$OPT_OUT_PATH" ]; then
        printf >&2 "error: output directory does not exist\n" && printf >&2 "%s\n" "$GITBUNDLEARCHIVE_USAGE" && exit 2
        exit 1
    fi

    OPT_OUT_PATH=$(readlink -f "$OPT_OUT_PATH")

    printf "GITBUNDLEARCHIVE:  in %s\n" "$OPT_IN_PATH"
    printf "GITBUNDLEARCHIVE: out %s\n" "$OPT_OUT_PATH"

    find "$OPT_IN_PATH" -type f -path "*.git/HEAD" | while read -r GIT_HEAD_FILE; do
        local GIT_DOT_DIR_PATH="$(dirname "$GIT_HEAD_FILE")"
        local GIT_DOT_DIR="$(basename "$GIT_DOT_DIR_PATH")"
        local REPO_FULL_PATH

        if [ "$GIT_DOT_DIR" = ".git" ]; then
            # This is repository with working directory.
            REPO_FULL_PATH="$(dirname "$GIT_DOT_DIR_PATH")"
        else
            # This is bare repository.
            REPO_FULL_PATH="$GIT_DOT_DIR_PATH"
        fi

        local REPO_NAME="$(basename "$REPO_FULL_PATH")"
        local REPO_PATH="${REPO_FULL_PATH#"$OPT_IN_PATH"}"
        local REPO_PATH="${REPO_PATH#/}"
        local REPO_PARENT_PATH="${REPO_PATH%"$REPO_NAME"}"
        local REPO_PARENT_PATH="${REPO_PARENT_PATH%/}"
        local BUNDLE_NAME

        if [ "$GIT_DOT_DIR" = ".git" ]; then
            # This is repository with working directory.
            BUNDLE_NAME="${REPO_NAME}.bundle"
        else
            # This is bare repository.
            REPO_NAME="${REPO_NAME%.git}"
            BUNDLE_NAME="${REPO_NAME}.bundle"
        fi

        if [ "$REPO_PARENT_PATH" = "" ]; then
            # Without parent path.
            printf "\nGITBUNDLEARCHIVE: %s -> %s\n" "$REPO_NAME".git "$BUNDLE_NAME"
        else
            # With parent path.
            printf "\nGITBUNDLEARCHIVE: %s/%s -> %s/%s\n" "$REPO_PARENT_PATH" "$REPO_NAME".git "$REPO_PARENT_PATH" "$BUNDLE_NAME"
        fi

        if [ -f "$OPT_OUT_PATH"/"$REPO_PARENT_PATH"/"$BUNDLE_NAME" ] ; then
            printf "GITBUNDLEARCHIVE: WARNING: already exist %s/%s/%s\n" "$OPT_OUT_PATH" "$REPO_PARENT_PATH" "$BUNDLE_NAME" >&2

            continue
        fi

        mkdir --parents "$OPT_OUT_PATH"/"$REPO_PARENT_PATH" || exit 1

        cd "$REPO_FULL_PATH" || exit 1
        git bundle create "$OPT_OUT_PATH"/"$REPO_PARENT_PATH"/"$BUNDLE_NAME" --all || exit 1
   done
}

optflagcheck () { { [ "$1" != "$EOL" ] && [ "$1" != '--' ]; } || { printf >&2 "missing argument %s\n" "$2"; return 2; } } # Avoid infinite loop.

gitbundlearchive "$@"
