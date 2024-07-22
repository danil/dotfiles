#!/usr/bin/env sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

OPTHELP="usage: ${CMD:=${0##*/}} --up|--down"

opthelp () { printf "%s\n" "$OPTHELP"; }
opttest () { { [ "$1" != "$EOL" ] && [ "$1" != '--' ]; } || optfail "missing argument" "$2"; } # Avoid infinite loop.
optfail () { printf >&2 "%s %s\n%s\n" "$1" "$2" "$OPTHELP"; exit 2; }
set -- "$@" "${EOL:=$(printf '\1\3\3\7')}"  # End-of-list marker.
while [ "$1" != "$EOL" ]; do
    opt="$1"; shift

    case "$opt" in
        --up  ) OPT_UP=0;;
        --down) OPT_DOWN=0;;
        -h | --help ) opthelp; exit 0;;

        # Process special cases.
        --) while [ "$1" != "$EOL" ]; do set -- "$@" "$1"; shift; done;;   # parse remaining as positional
        --[!=]*=*) set -- "${opt%%=*}" "${opt#*=}" "$@";;                  # "--opt=arg"  ->  "--opt" "arg"
        -[A-Za-z0-9] | -*[!A-Za-z0-9]*) optfail "unknown option:" "$opt";; # anything invalid like '-*'
        -?*) other="${opt#-?}"; set -- "${opt%$other}" "-${other}" "$@";;  # "-abc"  ->  "-a" "-bc"
        *) set -- "$@" "$opt";;                                            # positional, rotate to the end
    esac
done; shift

OPT_DRY=0

if [ "$OPT_UP" = 0 ]; then
    OPT_DRY=-1
    nmcli connection up WB passwd-file /root/openvpn/wbr/password
elif [ "$OPT_DOWN" = 0 ]; then
    OPT_DRY=-1
    nmcli connection down WB
fi


# Dry run.
if [ "$OPT_DRY" = 0 ]; then
    opthelp
    exit 1
fi
