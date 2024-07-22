#!/usr/bin/env sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

OPTHELP="usage: ${CMD:=${0##*/}} --light|--dark [--kde] [--alacritty] [--tmux] [--emacs] [--rofi] [--lsd]"

opthelp () { printf "%s\n" "$OPTHELP"; }
opttest () { { [ "$1" != "$EOL" ] && [ "$1" != '--' ]; } || optfail "missing argument" "$2"; } # Avoid infinite loop.
optfail () { printf >&2 "%s %s\n%s\n" "$1" "$2" "$OPTHELP"; exit 2; }
set -- "$@" "${EOL:=$(printf '\1\3\3\7')}"  # Parse command-line options. End-of-list marker.
while [ "$1" != "$EOL" ]; do
    opt="$1"; shift

    case "$opt" in
        --light    ) OPT_LIGHT=0;;
        --dark     ) OPT_DARK=0;;
        --kde      ) OPT_KDE=0;;
        --alacritty) OPT_ALACRITTY=0;;
        --tmux     ) OPT_TMUX=0;;
        --emacs    ) OPT_EMACS=0;;
        --rofi     ) OPT_ROFI=0;;
        --lsd      ) OPT_LSD=0;;
        -h | --help ) opthelp; exit 0;;

        # Process special cases.
        --) while [ "$1" != "$EOL" ]; do set -- "$@" "$1"; shift; done;;   # parse remaining as positional
        --[!=]*=*) set -- "${opt%%=*}" "${opt#*=}" "$@";;                  # "--opt=arg"  ->  "--opt" "arg"
        -[A-Za-z0-9] | -*[!A-Za-z0-9]*) optfail "unknown option:" "$opt";; # anything invalid like '-*'
        -?*) other="${opt#-?}"; set -- "${opt%$other}" "-${other}" "$@";;  # "-abc"  ->  "-a" "-bc"
        *) set -- "$@" "$opt";;                                            # positional, rotate to the end
    esac
done; shift

[ "$OPT_LIGHT" != 0 ] && [ "$OPT_DARK" != 0 ] && opthelp && exit 1
[ "$OPT_LIGHT" = 0 ] && [ "$OPT_DARK" = 0 ] && printf >&2 "error: ambiguous theme\n" && opthelp && exit 1

. /home/danil/bin/binpath.sh

theme_kde () {
    [ "$OPT_KDE" != 0 ] && return

    if [ ! -x "$(command -v lookandfeeltool)" ]; then
        printf >&2 "error: missing lookandfeeltool\n"
        return
    fi

    # KDE
    # <https://userbase.kde.org/System_Settings/Look_And_Feel>,
    # <https://askubuntu.com/questions/1183294/switching-plasma-theme-from-the-command-line#1183309>.
    if [ "$OPT_LIGHT" = 0 ]; then
        lookandfeeltool --apply org.kde.breeze.desktop || exit 1
    elif [ "$OPT_DARK" = 0 ]; then
        lookandfeeltool --apply org.kde.breezedark.desktop || exit 1
    fi
}

theme_alacritty () {
    [ "$OPT_ALACRITTY" != 0 ] && return

    if [ ! -f "$CONFIGDIR"/alacritty/alacritty_light.toml ] ||
       [ ! -f "$CONFIGDIR"/alacritty/alacritty_dark.toml ] ||
       [ ! -f "$CONFIGDIR"/alacritty/alacritty.toml ]; then
        printf >&2 "error: missing Alacrity theme\n"
    fi 

    cd "$CONFIGDIR"/alacritty || exit 1

    if [ "$OPT_LIGHT" = 0 ]; then
        ln --force --symbolic alacritty_light.toml alacritty_theme.toml || exit 1
    elif [ "$OPT_DARK" = 0 ]; then
        ln --force --symbolic alacritty_dark.toml alacritty_theme.toml || exit 1
    fi

    touch alacritty.toml || exit 1

    cd - > /dev/null || exit 1
}

theme_tmux () {
    [ "$OPT_TMUX" != 0 ] && return

    if [ ! -x "$(command -v "$BREWBINDIR"/tmux)" ]; then
        printf >&2 "error: missing tmux\n"
        return
    fi

    if [ "$OPT_LIGHT" = 0 ]; then
        "$BREWBINDIR"/tmux set -t $(hostname) status-bg brightwhite
        "$BREWBINDIR"/tmux set -t $(hostname) status-fg black
        "$BREWBINDIR"/tmux  set -t $(hostname) status-left "#[bg=brightred]#S#[bg=default]#(echo $USER)@#(hostname)#[bg=default]#[bg=brightmagenta]Ctl-t#[bg=default]"
        "$BREWBINDIR"/tmux  set-window-option -t $(hostname) window-status-current-style bg=brightblue
    elif [ "$OPT_DARK" = 0 ]; then
        "$BREWBINDIR"/tmux  set -t $(hostname) status-bg black
        "$BREWBINDIR"/tmux  set -t $(hostname) status-fg brightwhite
        "$BREWBINDIR"/tmux  set -t $(hostname) status-left "#[bg=red]#S#[bg=default]#(echo $USER)@#(hostname)#[bg=default]#[bg=magenta]Ctl-t#[bg=default]"
        "$BREWBINDIR"/tmux  set-window-option -t $(hostname) window-status-current-style bg=brightblue
    fi
}

theme_emacs () {
    [ "$OPT_EMACS" != 0 ] && return

    if [ ! -x "$(command -v "$BREWBINDIR"/emacsclient)" ]; then
        printf >&2 "error: missing emacsclient\n"
        return
    fi

    if [ "$OPT_LIGHT" = 0 ]; then
        "$HOMEBINDIR"/emacsclient --eval "(progn (setq frame-background-mode 'light) (load-file user-init-file))" --quiet -no-wait --suppress-output -a true
    elif [ "$OPT_DARK" = 0 ]; then
        "$HOMEBINDIR"/emacsclient --eval "(progn (setq frame-background-mode 'dark) (load-file user-init-file))" --quiet -no-wait --suppress-output -a true
    fi
}

theme_rofi () {
    [ "$OPT_ROFI" != 0 ] && return

    if [ ! -f "$CONFIGDIR"/rofi/config_light.rasi ] ||
       [ ! -f "$CONFIGDIR"/rofi/config_dark.rasi ]; then
        printf >&2 "error: missing Rofi theme\n"
    fi 

    cd "$CONFIGDIR"/rofi || exit 1

    if [ "$OPT_LIGHT" = 0 ]; then
        ln --force --symbolic config_light.rasi config.rasi || exit 1
    elif [ "$OPT_DARK" = 0 ]; then
        ln --force --symbolic config_dark.rasi config.rasi || exit 1
    fi

    touch rofi.toml || exit 1

    cd - > /dev/null || exit 1
}

theme_lsd () {
    [ "$OPT_LSD" != 0 ] && return

    if [ ! -f "$CONFIGDIR"/lsd/colors_light.yaml ] ||
       [ ! -f "$CONFIGDIR"/lsd/colors_dark.yaml ]; then
        printf >&2 "error: missing lsd theme\n"
    fi 

    cd "$CONFIGDIR"/lsd || exit 1

    if [ "$OPT_LIGHT" = 0 ]; then
        ln --force --symbolic colors_light.yaml colors.yaml || exit 1
    elif [ "$OPT_DARK" = 0 ]; then
        ln --force --symbolic colors_dark.yaml colors.yaml || exit 1
    fi

    cd - > /dev/null || exit 1
}

theme_kde
theme_alacritty
theme_tmux
theme_emacs
theme_rofi
theme_lsd
