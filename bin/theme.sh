#!/usr/bin/env sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

USAGE="usage: ${CMD:=${0##*/}} { --light | --dark } [--gnome] [--kde] [--alacritty] [--wezterm] [--tmux] [--emacs] [--btop] [--rofi] [--lsd] [--mailspring]"

OPT_ALL=0

opthelp () { if [ -n "$USAGE" ]; then printf "%s\n" "$USAGE"; else printf "error: optflag help text is not defied, please setup \$USAGE variable \n"; exit 1; fi; }
opttest () { { [ "$1" != "$EOL" ] && [ "$1" != '--' ]; } || optfail "missing argument" "$2"; } # Avoid infinite loop.
optfail () { printf >&2 "%s %s\n%s\n" "$1" "$2" "$USAGE"; exit 2; }
optflag () {
    set -- "$@" "${EOL:=$(printf '\1\3\3\7')}" # End-of-list marker.
    while [ "$1" != "$EOL" ]; do
        opt="$1"; shift

        case "$opt" in
            --light     ) OPT_LIGHT=0;;
            --dark      ) OPT_DARK=0;;
            --wallpaper ) OPT_WAL=0; OPT_ALL=-1;;
            --gnome     ) OPT_GNOME=0; OPT_ALL=-1;;
            --kde       ) OPT_KDE=0; OPT_ALL=-1;;
            --alacritty ) OPT_ALACRITTY=0; OPT_ALL=-1;;
            --wezterm   ) OPT_WEZTERM=0; OPT_ALL=-1;;
            --tmux      ) OPT_TMUX=0; OPT_ALL=-1;;
            --emacs     ) OPT_EMACS=0; OPT_ALL=-1;;
            --btop      ) OPT_BTOP=0; OPT_ALL=-1;;
            --rofi      ) OPT_ROFI=0; OPT_ALL=-1;;
            --lsd       ) OPT_LSD=0; OPT_ALL=-1;;
            --mailspring ) OPT_MAILSPRING=0; OPT_ALL=-1;;
            -h | --help ) opthelp; exit 0;;

            # Process special cases.
            --) while [ "$1" != "$EOL" ]; do set -- "$@" "$1"; shift; done;;   # Parse remaining as positional.
            --[!=]*=*) set -- "${opt%%=*}" "${opt#*=}" "$@";;                  # "--opt=arg"  ->  "--opt" "arg"
            -[A-Za-z0-9] | -*[!A-Za-z0-9]*) optfail "unknown option:" "$opt";; # Anything invalid like "-*".
            -?*) other="${opt#-?}"; set -- "${opt%$other}" "-${other}" "$@";;  # "-abc"  ->  "-a" "-bc"
            *) set -- "$@" "$opt";;                                            # Positional, rotate to the end.
        esac
    done; shift
}
optflag "$@"

[ "$OPT_LIGHT" != 0 ] && [ "$OPT_DARK" != 0 ] && opthelp && exit 2
[ "$OPT_LIGHT" = 0 ] && [ "$OPT_DARK" = 0 ] && printf >&2 "error: ambiguous theme\n" && opthelp && exit 2

if [ "$OPT_ALL" = 0 ]; then
    OPT_WAL=0
    OPT_GNOME=0
    OPT_KDE=0
    OPT_ALACRITTY=0
    OPT_WEZTERM=0
    OPT_TMUX=0
    OPT_EMACS=0
    OPT_BTOP=0
    OPT_MAILSPRING=0
fi

. /home/danil/bin/binpath.sh

theme_wallpaper () {
    [ "$OPT_WAL" != 0 ] && return

    OPTFLAGDRYRUN=-1

    lightbg="$SHAREDIR"/backgrounds/2021-07-29.18.50.41-v2.jpg
    darkbg="$SHAREDIR"/backgrounds/2018-03-16.19.25.25-v2.jpg

    if [ ! -f "$lightbg" ] ||
       [ ! -f "$darkbg" ]; then
        printf >&2 "error: missing the wallpaper file\n"
    fi

    # X11.
    if [ ! -x "$(command -v feh)" ]; then
        printf >&2 "error: missing the feh executable file\n"
    else
        if [ "$OPT_LIGHT" = 0 ]; then
            feh --bg-center  "$lightbg"
        elif [ "$OPT_DARK" = 0 ]; then
            feh --bg-center "$darkbg"
        fi
    fi

    # GNOME.
    if [ ! -x "$(command -v gsettings)" ]; then
        printf >&2 "error: missing the gsettings executable file\n"
    else
        if [ "$OPT_LIGHT" = 0 ]; then
            gsettings set org.gnome.desktop.background picture-uri      "file://$lightbg"
        elif [ "$OPT_DARK" = 0 ]; then
            gsettings set org.gnome.desktop.background picture-uri-dark "file://$darkbg"
        fi
    fi

    # KDE
    # <https://userbase.kde.org/System_Settings/Look_And_Feel>,
    # <https://askubuntu.com/questions/1183294/switching-plasma-theme-from-the-command-line#1183309>.
    if [ ! -x "$(command -v plasma-apply-wallpaperimage)" ]; then
        printf >&2 "error: missing the plasma-apply-wallpaperimage executable file\n"
    else
        if [ "$OPT_LIGHT" = 0 ]; then
            plasma-apply-wallpaperimage "$lightbg"
        elif [ "$OPT_DARK" = 0 ]; then
            plasma-apply-wallpaperimage "$darkbg"
        fi
    fi
}


theme_gnome () {
    [ "$OPT_GNOME" != 0 ] && return

    OPTFLAGDRYRUN=-1

    if [ ! -x "$(command -v gsettings)" ]; then
        printf >&2 "error: missing the gsettings executable file\n"
        return
    fi

    if [ "$OPT_LIGHT" = 0 ]; then
        gsettings set org.gnome.desktop.interface color-scheme prefer-light || exit 1
        dconf write /org/gnome/desktop/interface/color-scheme "'prefer-light'"
        dconf write /org/gnome/desktop/interface/gtk-theme "'Breeze'"
    elif [ "$OPT_DARK" = 0 ]; then
        gsettings set org.gnome.desktop.interface color-scheme prefer-dark || exit 1
        dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
        dconf write /org/gnome/desktop/interface/gtk-theme "'Breeze-Dark'"
    fi
}

theme_kde () {
    [ "$OPT_KDE" != 0 ] && return

    OPTFLAGDRYRUN=-1

    if [ ! -x "$(command -v lookandfeeltool)" ]; then
        printf >&2 "error: missing the lookandfeeltool executable file\n"
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

    OPTFLAGDRYRUN=-1

    if [ ! -f "$CONFIGDIR"/alacritty/alacritty_light.toml ] ||
       [ ! -f "$CONFIGDIR"/alacritty/alacritty_dark.toml ] ||
       [ ! -f "$CONFIGDIR"/alacritty/alacritty.toml ]; then
        printf >&2 "error: missing the Alacritty theme file\n"
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

theme_wezterm () {
    [ "$OPT_WEZTERM" != 0 ] && return

    OPTFLAGDRYRUN=-1

    if [ ! -f "$CONFIGDIR"/wezterm/wezterm_light.lua ] ||
       [ ! -f "$CONFIGDIR"/wezterm/wezterm_dark.lua ] ||
       [ ! -f "$CONFIGDIR"/wezterm/wezterm.lua ]; then
        printf >&2 "error: missing the Wezterm theme file\n"
    fi

    cd "$CONFIGDIR"/wezterm || exit 1

    if [ "$OPT_LIGHT" = 0 ]; then
        ln --force --symbolic wezterm_light.lua wezterm_theme.lua || exit 1
    elif [ "$OPT_DARK" = 0 ]; then
        ln --force --symbolic wezterm_dark.lua wezterm_theme.lua || exit 1
    fi

    touch wezterm.lua || exit 1

    cd - > /dev/null || exit 1
}

theme_tmux () {
    [ "$OPT_TMUX" != 0 ] && return

    OPTFLAGDRYRUN=-1

    if [ ! -x "$(command -v "$HOMEBINDIR"/tmux)" ]; then
        printf >&2 "error: missing the tmux executable file\n"
        return
    fi

    if [ "$OPT_LIGHT" = 0 ]; then
        "$HOMEBINDIR"/tmux -S /tmp/tmux-pair set -t $(hostname) status-bg brightwhite
        "$HOMEBINDIR"/tmux -S /tmp/tmux-pair set -t $(hostname) status-fg black
        "$HOMEBINDIR"/tmux -S /tmp/tmux-pair set -t $(hostname) status-left "#[bg=brightred]#S#[bg=default]#(echo $USER)@#(hostname)#[bg=default]#[bg=brightmagenta]Ctl-t#[bg=default]"
        "$HOMEBINDIR"/tmux -S /tmp/tmux-pair set-window-option -t $(hostname) window-status-current-style bg=brightblue
    elif [ "$OPT_DARK" = 0 ]; then
        "$HOMEBINDIR"/tmux -S /tmp/tmux-pair set -t $(hostname) status-bg black
        "$HOMEBINDIR"/tmux -S /tmp/tmux-pair set -t $(hostname) status-fg brightwhite
        "$HOMEBINDIR"/tmux -S /tmp/tmux-pair set -t $(hostname) status-left "#[bg=red]#S#[bg=default]#(echo $USER)@#(hostname)#[bg=default]#[bg=magenta]Ctl-t#[bg=default]"
        "$HOMEBINDIR"/tmux -S /tmp/tmux-pair set-window-option -t $(hostname) window-status-current-style bg=brightblue
    fi
}

theme_emacs () {
    [ "$OPT_EMACS" != 0 ] && return

    OPTFLAGDRYRUN=-1

    if [ ! -x "$(command -v "$HOMEBINDIR"/emacsclient)" ]; then
        printf >&2 "error: missing the emacsclient executable file\n"
        return
    fi

    if [ "$OPT_LIGHT" = 0 ]; then
        "$HOMEBINDIR"/emacsclient --eval "(progn (setq frame-background-mode 'light) (load-file user-init-file))" --quiet -no-wait --suppress-output -a true
    elif [ "$OPT_DARK" = 0 ]; then
        "$HOMEBINDIR"/emacsclient --eval "(progn (setq frame-background-mode 'dark) (load-file user-init-file))" --quiet -no-wait --suppress-output -a true
    fi
}

theme_btop () {
    [ "$OPT_BTOP" != 0 ] && return

    OPTFLAGDRYRUN=-1

    if [ ! -x "$(command -v btop)" ]; then
        printf >&2 "error: missing the btop executable file\n"
        return
    fi

    if [ ! -f "$CONFIGDIR"/btop/themes/oledlight.theme ]; then
        printf >&2 "error: missing the btop theme file\n"
    fi

    cd "$CONFIGDIR"/btop/themes || exit 1

    if [ "$OPT_LIGHT" = 0 ]; then
        ln --force --symbolic oledlight.theme oled.theme || exit 1
    elif [ "$OPT_DARK" = 0 ]; then
        rm -f oled.theme || exit 1
    fi

    pkill -USR2 btop
    cd - > /dev/null || exit 1
}

theme_rofi () {
    [ "$OPT_ROFI" != 0 ] && return

    OPTFLAGDRYRUN=-1

    if [ ! -f "$CONFIGDIR"/rofi/config_light.rasi ] ||
       [ ! -f "$CONFIGDIR"/rofi/config_dark.rasi ]; then
        printf >&2 "error: missing the Rofi theme file\n"
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

    OPTFLAGDRYRUN=-1

    if [ ! -f "$CONFIGDIR"/lsd/colors_light.yaml ] ||
       [ ! -f "$CONFIGDIR"/lsd/colors_dark.yaml ]; then
        printf >&2 "error: missing the lsd theme file\n"
    fi

    cd "$CONFIGDIR"/lsd || exit 1

    if [ "$OPT_LIGHT" = 0 ]; then
        ln --force --symbolic colors_light.yaml colors.yaml || exit 1
    elif [ "$OPT_DARK" = 0 ]; then
        ln --force --symbolic colors_dark.yaml colors.yaml || exit 1
    fi

    cd - > /dev/null || exit 1
}

theme_mailspring () {
    [ "$OPT_MAILSPRING" != 0 ] && return

    OPTFLAGDRYRUN=-1

    if [ ! -f "$SNAPDIR"/mailspring/common/config.json ]; then
        printf >&2 "error: missing the mailspring theme file\n"
    fi

    cd "$SNAPDIR"/mailspring/common || exit 1

    if [ "$OPT_LIGHT" = 0 ]; then
        sed --in-place 's/"ui-dark"/"ui-light"/g' config.json || exit 1
    elif [ "$OPT_DARK" = 0 ]; then
        sed --in-place 's/"ui-light"/"ui-dark"/g' config.json || exit 1
    fi

    cd - > /dev/null || exit 1
}

theme_wallpaper
theme_gnome
theme_kde
theme_alacritty
theme_wezterm
theme_tmux
theme_emacs
theme_btop
theme_rofi
theme_lsd
theme_mailspring

# Dry run.
if [ "$OPTFLAGDRYRUN" = 0 ]; then
    printf >&2 "error: theme dry run\n"
    opthelp
    exit 2
fi
