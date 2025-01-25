#!/usr/bin/env sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

VPNUSAGE="usage: ${CMD:=${0##*/}} { --up | --down } [ --force ] [ --status ] [ --verbose ]"

vpnup () {
    # nmcli connection up WB passwd-file /root/openvpn/wbr/password
    sudo systemctl start wb_vpn.service || exit 1
}

vpndown () {
    # nmcli connection down WB
    tsh logout
    sudo systemctl stop wb_vpn.service || exit 1
}

vpndnsup () {
    if ! grep --quiet "nameserver.*10.15.12.200" /etc/resolv.conf; then
        sudo sed -i -z 's/\(nameserver.*127.0.0.53\n\)/nameserver 10.15.12.200\n\1/g' /etc/resolv.conf
    fi
    if ! grep --quiet "nameserver 10.15.12.100" /etc/resolv.conf; then
        sudo sed -i -z 's/\(nameserver 127.0.0.53\n\)/nameserver 10.15.12.100\n\1/g' /etc/resolv.conf
    fi
}

vpndnsdown () {
    sudo sed -i -z 's/nameserver.*10.15.12.100\n//g' /etc/resolv.conf
    sudo sed -i -z 's/nameserver.*10.15.12.200\n//g' /etc/resolv.conf
}

optflagcheck () { { [ "$1" != "$EOL" ] && [ "$1" != '--' ]; } || { printf >&2 "missing argument %s\n" "$2"; return 2; } } # Avoid infinite loop.


vpnopt () {
    set -- "$@" "${EOL:=$(printf '\1\3\3\7')}" # End-of-list marker.
    local OPTFLAGEXIT=0
    while [ "$1" != "$EOL" ]; do
        local OPTFLAG="$1"; shift

        case "$OPTFLAG" in
            --up     ) local OPT_UP=0;;
            --down   ) local OPT_DOWN=0;;
            --status ) local OPT_STATUS=0;;
            -v | --verbose ) local OPT_VERBOSE=0;;
            -h | --help    ) printf "%s\n" "$VPNUSAGE"; exit 0;;

            # Process special cases.
            --) while [ "$1" != "$EOL" ]; do set -- "$@" "$1"; shift; done;;           # Parse remaining as positional.
            --[!=]*=*) set -- "${OPTFLAG%%=*}" "${OPTFLAG#*=}" "$@";;                  # "--OPTFLAG=arg"  ->  "--OPTFLAG" "arg"
            -[A-Za-z0-9] | -*[!A-Za-z0-9]*) printf >&2 "unknown option: %s\n" "$OPTFLAG"; OPTFLAGEXIT=2;; # Anything invalid like "-*".
            -?*) other="${OPTFLAG#-?}"; set -- "${OPTFLAG%$other}" "-${other}" "$@";;  # "-abc"  ->  "-a" "-bc"
            *) set -- "$@" "$OPTFLAG";;                                                # Positional, rotate to the end.
        esac

        [ "$OPTFLAGEXIT" != 0 ] && break
    done; shift

    [ "$OPTFLAGEXIT" != 0 ] && printf >&2 "%s\n" "$VPNUSAGE" && exit "$OPTFLAGEXIT"

    if [ "$OPT_UP" = 0 ] && [ "$OPT_DOWN" = 0 ] ; then
        printf >&2 "error: ambiguous command\n"
        printf >&2 "%s\n" "$VPNUSAGE"
        exit 2
    fi

    local OPTFLAGDRYRUN=0

    if [ "$OPT_UP" = 0 ] ; then
        OPTFLAGDRYRUN=-1
        vpnup
        vpndnsup
    fi

    if [ "$OPT_DOWN" = 0 ] ; then
        OPTFLAGDRYRUN=-1
        vpndown
        vpndnsdown
    fi

    if [ "$OPT_STATUS" = 0 ] ; then
        OPTFLAGDRYRUN=-1
        cat /etc/resolv.conf | grep --invert-match "^$" | grep --invert-match "^#"
        systemctl status wb_vpn.service | grep -i active
        [ "$OPT_VERBOSE" = 0 ] && tsh status | grep -i logged
    fi

    [ "$OPTFLAGDRYRUN" = 0 ] && printf >&2 "error: makehome dry run\n%s\n" "$VPNUSAGE" && exit 2 # Dry run.
}

trap exit INT

vpnopt "$@"
