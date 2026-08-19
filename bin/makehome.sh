#!/usr/bin/env dash

# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

# APT (deb/dpkg/apt-get/aptitude)
# <https://en.wikipedia.org/wiki/APT_(software)>.
APTO_INS_CLI="sudo aptitude install --without-recommends"
APTO_UNI_CLI="sudo aptitude remove"
# APTO_DIS_CLI="systemctl disable"

# Zypper <https://github.com/openSUSE/zypper>.
ZYPP_INS_CLI="sudo zypper install --no-recommends"
ZYPP_UNI_CLI="sudo zypper remove"

# Zypper pattern <https://github.com/openSUSE/zypper>.
ZYPA_INS_CLI="sudo zypper install --no-recommends --type pattern"
ZYPA_UNI_CLI="sudo zypper remove"

makebrewinst () {
    export HOMEBREW_NO_AUTO_UPDATE=1 && brew install "$@"
}

makebrewreinst () {
    export HOMEBREW_NO_AUTO_UPDATE=1
    export HOMEBREW_COLOR=1

    printf "\nMAKEHOME: brew install %s\n" "$@"
    ins_out="$(brew install "$@" 2>&1)"
    printf "%s\n" "$ins_out"

    case "$ins_out" in
        *"is already installed and up-to-date."*|*"is already installed."*)
        printf "MAKEHOME: brew reinstall %s\n" "$@"
        rin_out="$(brew reinstall "$@" 2>&1)"
        printf "%s\n" "$rin_out"
        ;;
    esac

    case "$ins_out" in
        *"is already installed, it's just not linked."*)
        printf "MAKEHOME: brew link %s\n" "$@"
        brew link $@
        ;;
    esac

    case "$ins_out" in
        *"is already installed"*"To install"*"first run:"*"brew unlink"*)
        echo "xxxxxxxxxxxxxxxxxxxx"
        printf "MAKEHOME: brew unlink %s\n" "$@"
        brew unlink $@
        printf "MAKEHOME: brew install %s\n" "$@"
        brew install $@
        ;;
    esac

    case "$rin_out" in
        *"Could not rename"*"keg! Check/fix its permissions:"*)
        printf "MAKEHOME: brew link %s\n" "$@"
        lin_out="$(brew link "$@" 2>&1)"
        printf "%s\n" "$lin_out"
        ;;
    esac

    # case "$lin_out" in
    #     *"is keg-only and must be linked with \`--force\`."*)
    #     printf "MAKEHOME: brew link --force %s\n" "$@"
    #     brew link --force $@
    #     ;;
    # esac
}

# Homebrew
# <https://github.com/Homebrew/brew>.
BREW_INS_SRC_CLI="brew tap"
BREW_UNI_SRC_CLI="brew untap"
BREW_INS_CLI="makebrewinst"
BREW_RIN_CLI="makebrewreinst"
BREW_UPD_CLI="brew install"

# AppImage
# <https://github.com/appimage/appimagekit>.
APPM_INS_CLI="appman -i"
APPM_UPD_CLI="appman -u"

# Pacstall
# <https://github.com/pacstall/pacstall>.
PACS_INS_CLI="pacstall --install --disable-prompts --keep"
PACS_UPD_CLI="pacstall --install --disable-prompts --keep"
PACS_UNI_CLI="pacstall --remove"

# Snap
# <https://github.com/snapcore/snapd>.
SNAP_INS_CLI="sudo snap install"
SNAP_UPD_CLI="sudo snap refresh"
SNAP_UNI_CLI="sudo snap remove"

# Snap classic
# <https://github.com/snapcore>.
SNAC_INS_CLI="sudo snap install --classic"
SNAC_UPD_CLI="sudo snap refresh"
SNAC_UNI_CLI="sudo snap remove"

# Flatpak
# <https://github.com/flatpak/flatpak>.
FLAT_INS_SRC_CLI="flatpak remote-add --if-not-exists"
FLAT_UNI_SRC_CLI="flatpak remote-delete"
FLAT_INS_CLI="flatpak install flathub"

# # Zig package
# # <https://ziglang.org>.
# ZIGL_INS_CLI="zig build"
# ZIGL_UPD_CLI="zig build"

# Go package
# <https://go.dev/ref/mod#go-install>.
GOLN_INS_CLI="go install"
GOLN_UPD_CLI="go install"

# Rust Cargo
# <https://github.com/rust-lang/cargo>,
# <https://doc.rust-lang.org/cargo>.
RUST_INS_CLI="cargo install"
RUST_UPD_CLI="cargo install --force"

# Python2 pip
# <https://github.com/pypa/pip>.
PIP2_INS_CLI="pip2 install --user"
PIP2_UPD_CLI="pip2 install --user --upgrade"

# Python3 pip
# <https://github.com/pypa/pip>.
PIP3_INS_CLI="pip3 install --user"
PIP3_UPD_CLI="pip3 install --user --upgrade"

# NPM JavaScript package
# <https://github.com/npm>.
NPMJ_INS_CLI="npm install"
NPMJ_UPD_CLI="npm update"

# MAKEHOMEUSAGE="usage: ${CMD:=${0##*/}} { --install | --reinstall | --update | --config  } [--homebrew] [--appimage] [--apt] [--zypper] [--snap] [--pacstall] [--flatpak] [--go] [--rust] [--python2] [--python3] [--update] [--etc] [--root] [--home=\"\$HOME\"]"
MAKEHOMEUSAGE="usage: makehome { --install | --reinstall | --update | --config  } [--homebrew] [--appimage] [--zypper] [--apt] [--snap] [--pacstall] [--flatpak] [--go] [--rust] [--python2] [--python3] [--npm] [--update] [--etc] [--root] [--home=\"\$HOME\"]"

makehome () {
    local OPT_ALL_PACKAGES=-1
    local OPT_JOBS=$(grep -c ^processor /proc/cpuinfo)
    OPT_JOBS=${OPT_JOBS:-1}

    local OPTFLAGEXIT=0
    set -- "$@" "${EOL:=$(printf '\1\3\3\7')}" # End-of-list marker.
    while [ "$1" != "$EOL" ]; do
        local OPTFLAG="$1"; shift

        case "$OPTFLAG" in
            --install   ) local OPT_INSTALL=0;;
            --reinstall ) local OPT_REINSTALL=0;;
            --update    ) local OPT_UPDATE=0;;
            --config    ) local OPT_CONFIG=0;;
            --apt       ) local OPT_APTO=0; OPT_ALL_PACKAGES=-1;;
            --zypper    ) local OPT_ZYPP=0; OPT_ZYPA=0; OPT_ALL_PACKAGES=-1;;
            --homebrew  ) local OPT_BREW=0; OPT_ALL_PACKAGES=-1;;
            --appimage  ) local OPT_APPL=0; local OPT_APPM=0; OPT_ALL_PACKAGES=-1;;
            --pacstall  ) local OPT_PACS=0; OPT_ALL_PACKAGES=-1;;
            --snap      ) local OPT_SNAP=0; local OPT_SNAC=0; OPT_ALL_PACKAGES=-1;;
            --flatpak   ) local OPT_FLAT=0; OPT_ALL_PACKAGES=-1;;
            --go        ) local OPT_GOLN=0; OPT_ALL_PACKAGES=-1;;
            --rust      ) local OPT_RUST=0; OPT_ALL_PACKAGES=-1;;
            --python2   ) local OPT_PIP2=0; OPT_ALL_PACKAGES=-1;;
            --python3   ) local OPT_PIP3=0; OPT_ALL_PACKAGES=-1;;
            --npm       ) local OPT_NPMJ=0; OPT_ALL_PACKAGES=-1;;
            --home      ) optflagcheck "$1" "$OPTFLAG"; OPTFLAGEXIT=$?; local OPT_HOME="$1"; OPT_ALL_PACKAGES=-1; shift;;
            --etc       ) local OPT_ETCE="/etc"; OPT_ALL_PACKAGES=-1;;
            --root      ) local OPT_ROOT="/"; OPT_ALL_PACKAGES=-1;;
            --jobs      ) optflagcheck "$1" "$OPTFLAG"; OPTFLAGEXIT=$?; OPT_JOBS="$1"; shift;;
            -v | --verbose ) local OPT_VERBOSE=0;;
            -h | --help    ) printf "%s\n" "$MAKEHOMEUSAGE"; exit 0;;

            # Process special cases.
            --) while [ "$1" != "$EOL" ]; do set -- "$@" "$1"; shift; done;;                              # Parse remaining as positional.
            --[!=]*=*) set -- "${OPTFLAG%%=*}" "${OPTFLAG#*=}" "$@";;                                     # "--OPTFLAG=arg"  ->  "--OPTFLAG" "arg"
            -[A-Za-z0-9] | -*[!A-Za-z0-9]*) printf >&2 "unknown option: %s\n" "$OPTFLAG"; OPTFLAGEXIT=2;; # Anything invalid like "-*".
            -?*) other="${OPTFLAG#-?}"; set -- "${OPTFLAG%$other}" "-${other}" "$@";;                     # "-abc"  ->  "-a" "-bc"
            *) set -- "$@" "$OPTFLAG";;                                                                   # Positional, rotate to the end.
        esac

        [ "$OPTFLAGEXIT" != 0 ] && break
    done; shift

    [ "$OPTFLAGEXIT" != 0 ] && printf >&2 "%s\n" "$MAKEHOMEUSAGE" && exit "$OPTFLAGEXIT"

    local cmd_count=0
    [ "$OPT_INSTALL"   = 0 ] && cmd_count=$((cmd_count+1))
    [ "$OPT_REINSTALL" = 0 ] && cmd_count=$((cmd_count+1))
    [ "$OPT_UPDATE"    = 0 ] && cmd_count=$((cmd_count+1))
    [ "$OPT_CONFIG"    = 0 ] && cmd_count=$((cmd_count+1))
    [ "$cmd_count" -lt 1 ] && printf >&2 "error: missing command\n" && printf >&2 "%s\n" "$MAKEHOMEUSAGE" && exit 2
    [ "$cmd_count" -gt 1 ] && printf >&2 "error: ambiguous command\n" && printf >&2 "%s\n" "$MAKEHOMEUSAGE" && exit 2

    local OPTFLAGDRYRUN=0

    if [ "$OPT_INSTALL" = 0 ]; then
        BREW_RIN_CLI=""
        APPM_RIN_CLI=""
        SNAP_RIN_CLI=""
        PACS_RIN_CLI=""
        GOLN_RIN_CLI=""
        GOLN_RIN_CLI=""
        RUST_RIN_CLI=""
        PIP2_RIN_CLI=""
        PIP3_RIN_CLI=""
        NPMJ_RIN_CLI=""
    fi

    if [ "$OPT_REINSTALL" = 0 ]; then
        BREW_INS_CLI=""
        APPM_INS_CLI=""
        SNAP_INS_CLI=""
        PACS_INS_CLI=""
        GOLN_INS_CLI=""
        GOLN_INS_CLI=""
        RUST_INS_CLI=""
        PIP2_INS_CLI=""
        PIP3_INS_CLI=""
        NPMJ_INS_CLI=""
    fi

    if [ "$OPT_UPDATE" = 0 ]; then
        BREW_INS_CLI="$BREW_UPD_CLI"
        APPM_INS_CLI="$APPM_UPD_CLI"
        SNAP_INS_CLI="$SNAP_UPD_CLI"
        PACS_INS_CLI="$PACS_UPD_CLI"
        GOLN_INS_CLI="$GOLN_UPD_CLI"
        GOLN_INS_CLI="$GOLN_UPD_CLI"
        RUST_INS_CLI="$RUST_UPD_CLI"
        PIP2_INS_CLI="$PIP2_UPD_CLI"
        PIP3_INS_CLI="$PIP3_UPD_CLI"
        NPMJ_INS_CLI="$NPMJ_UPD_CLI"
    fi

    if [ "$OPT_VERBOSE" = 0 ] ; then
        RUST_INS_CLI="$RUST_INS_CLI --verbose"
    fi

    # makeinst --description="AppImageLauncher AppImage packages" --make="$OPT_APPL" --install-fast-exit-loop "$APPL_INS_CLI" "$APPL_INS" # AppImageLauncher install AppImages <https://github.com/theassassin/appimagelauncher>, <https://github.com/appimage/appimagekit>
    makeinst --description="APT packages"             --make="$OPT_APTO" --install-command="$APTO_INS_CLI" --install-packages="$APTO_INS" --install-line-fast-exit --uninstall-command="$APTO_UNI_CLI" --uninstall-packages="$APTO_UNI" --uninstall-line-fast-exit # FIXME: sh -c "sudo $APTO_DIS_CLI $APTO_DIS" || exit 1 # Advanced package tool (APT/deb/dpkg/apt-get/aptitude) <https://en.wikipedia.org/wiki/APT_(software)>.
    makeinst --description="Zypper packages"          --make="$OPT_ZYPP" --install-command="$ZYPP_INS_CLI" --install-packages="$ZYPP_INS" --install-line-fast-exit --uninstall-command="$ZYPP_UNI_CLI" --uninstall-packages="$ZYPP_UNI" --uninstall-line-fast-exit # Zypper packages <https://github.com/openSUSE/zypper>.
    makeinst --description="Zypper package patterns"  --make="$OPT_ZYPA" --install-command="$ZYPA_INS_CLI" --install-packages="$ZYPA_INS" --install-line-fast-exit --uninstall-command="$ZYPA_UNI_CLI" --uninstall-packages="$ZYPA_UNI" --uninstall-line-fast-exit # Zypper patterns <https://github.com/openSUSE/zypper>.
    makeinst --description="Homebrew packages"        --make="$OPT_BREW" --install-command="$BREW_INS_CLI" --install-packages="$BREW_INS" --install-line-fast-exit --reinstall-command="$BREW_RIN_CLI" --reinstall-packages="$BREW_INS" --reinstall-loop-skip-exit --install-source-command="$BREW_INS_SRC_CLI" --install-source-packages="${BREW_INS_SRC}" --install-source-loop-fast-exit # FIXME: for src in ${BREW_UNI_SRC}; do sh -c "$BREW_UNI_SRC_CLI $src" || exit 1; done # Homebrew <https://brew.sh>.
    makeinst --description="AppMan AppImage packages" --make="$OPT_APPM" --install-command="$APPM_INS_CLI" --install-packages="$APPM_INS" --install-line-skip-exit # AppMan install AppImages <https://github.com/ivan-hc/appman>, <https://github.com/appimage/appimagekit>.
    makeinst --description="Snap packages"            --make="$OPT_SNAP" --install-command="$SNAP_INS_CLI" --install-packages="$SNAP_INS" --install-loop-fast-exit --uninstall-command="$SNAP_UNI_CLI" --uninstall-packages="$SNAP_UNI" --uninstall-line-fast-exit # Snap <https://github.com/snapcore/snapd>.
    makeinst --description="Snap classic packages"    --make="$OPT_SNAC" --install-command="$SNAC_INS_CLI" --install-packages="$SNAC_INS" --install-loop-fast-exit --uninstall-command="$SNAC_UNI_CLI" --uninstall-packages="$SNAC_UNI" --uninstall-line-fast-exit # Snap <https://github.com/snapcore/snapd>.
    makeinst --description="Pacstall packages"        --make="$OPT_PACS" --install-command="$PACS_INS_CLI" --install-packages="$PACS_INS" --install-line-fast-exit --uninstall-command="$PACS_UNI_CLI" --uninstall-packages="$PACS_UNI" --uninstall-line-fast-exit
    makeinst --description="Flatpak packages"         --make="$OPT_FLAT" --install-command="$FLAT_INS_CLI" --install-packages="$FLAT_INS" --install-line-fast-exit # FIXME: FLAT_INS_SRC_CLI # FIXME: FLAT_UNI_SRC_CLI # Flatpak <https://github.com/flatpak/flatpak>.
    makeinst --description="Go packages"              --make="$OPT_GOLN" --install-command="$GOLN_INS_CLI" --install-packages="$GOLN_INS" --install-loop-fast-exit # Go <https://go.dev/ref/mod#go-install>.
    makeinst --description="Rust Cargo packages"      --make="$OPT_RUST" --install-command="$RUST_INS_CLI" --install-packages="$RUST_INS" --install-loop-fast-exit # Rust Cargo <https://github.com/rust-lang/cargo>, <https://doc.rust-lang.org/cargo>.
    makeinst --description="Python2 pip packages"     --make="$OPT_PIP2" --install-command="$PIP2_INS_CLI" --install-packages="$PIP2_INS" --install-line-fast-exit # Python2 PIP <https://github.com/pypa/pip>.
    makeinst --description="Python3 pip packages"     --make="$OPT_PIP3" --install-command="$PIP3_INS_CLI" --install-packages="$PIP3_INS" --install-line-fast-exit # Python3 PIP <https://github.com/pypa/pip>.
    makeinst --description="NPM JavaScript packages"  --make="$OPT_NPMJ" --install-command="$NPMJ_INS_CLI" --install-packages="$NPMJ_INS" --install-line-fast-exit # NPM JavaScript package <https://github.com/npm>.

    makeconf "$OPT_HOME" # $HOME user home directory <https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard#Directory_structure>.
    makeconf "$OPT_ETCE" # /etc of host-specific system-wide configuration <https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard#Directory_structure>.
    makeconf "$OPT_ROOT" # / is the root directory of host-specific system-wide configuration <https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard#Directory_structure>.

    [ "$OPTFLAGDRYRUN" = 0 ] && printf >&2 "error: makehome dry run\n%s\n" "$MAKEHOMEUSAGE" && exit 2 # Dry run.
    printf "%s successfully\n" "${CMD:=${0##*/}}"
}

optflagcheck () { { [ "$1" != "$EOL" ] && [ "$1" != '--' ]; } || { printf >&2 "missing argument %s\n" "$2"; return 2; } } # Avoid infinite loop.

MAKEINSTUSAGE="usage: makeinst --make=0 --description=\"text\" [ --install-command=\"apt install\" --install-packages=\"pkg pkg2\" { --install-fast-exit-line | --install-skip-exit-line | --install-fast-exit-loop | --install-skip-exit-loop } ] [ --install-source-command=\"apt install\" --install-source-packages=\"pkg pkg2\" { --install-source-fast-exit-line | --install-source-skip-exit-line | --install-source-fast-exit-loop | --install-source-skip-exit-loop } ] [ --uninstall-command=\"apt uninstall\" --uninstall-packages=\"pkg pkg2\" { --uninstall-fast-exit-line | --uninstall-skip-exit-line | --uninstall-fast-exit-loop | --uninstall-skip-exit-loop } ]"

makeinst () {
    set -- "$@" "${EOL:=$(printf '\1\3\3\7')}" # End-of-list marker.
    local OPTFLAGEXIT=0
    while [ "$1" != "$EOL" ]; do
        local OPTFLAG="$1"; shift

        case "$OPTFLAG" in
            --make        ) optflagcheck "$1" "$OPTFLAG"; local MAKEINST="$1"; shift;;
            --description ) optflagcheck "$1" "$OPTFLAG"; local DESCRIPTION="$1"; shift;;

            --install-command        ) optflagcheck "$1" "$OPTFLAG"; OPTFLAGEXIT=$?; local INS_CLI="$1"; shift;;
            --install-packages       ) optflagcheck "$1" "$OPTFLAG"; OPTFLAGEXIT=$?; local INS_PKG="$1"; shift;;
            --install-line-fast-exit ) local INS_FAST_EXIT_LINE=0;;
            --install-line-skip-exit ) local INS_SKIP_EXIT_LINE=0;;
            --install-loop-fast-exit ) local INS_FAST_EXIT_LOOP=0;;
            --install-loop-skip-exit ) local INS_SKIP_EXIT_LOOP=0;;

            --uninstall-command        ) optflagcheck "$1" "$OPTFLAG"; OPTFLAGEXIT=$?; local UNI_CLI="$1"; shift;;
            --uninstall-packages       ) optflagcheck "$1" "$OPTFLAG"; OPTFLAGEXIT=$?; local UNI_PKG="$1"; shift;;
            --uninstall-line-fast-exit ) local UNI_FAST_EXIT_LINE=0;;
            --uninstall-line-skip-exit ) local UNI_SKIP_EXIT_LINE=0;;
            --uninstall-loop-fast-exit ) local UNI_FAST_EXIT_LOOP=0;;
            --uninstall-loop-skip-exit ) local UNI_SKIP_EXIT_LOOP=0;;

            --reinstall-command        ) optflagcheck "$1" "$OPTFLAG"; OPTFLAGEXIT=$?; local RIN_CLI="$1"; shift;;
            --reinstall-packages       ) optflagcheck "$1" "$OPTFLAG"; OPTFLAGEXIT=$?; local RIN_PKG="$1"; shift;;
            --reinstall-line-fast-exit ) local RIN_FAST_EXIT_LINE=0;;
            --reinstall-line-skip-exit ) local RIN_SKIP_EXIT_LINE=0;;
            --reinstall-loop-fast-exit ) local RIN_FAST_EXIT_LOOP=0;;
            --reinstall-loop-skip-exit ) local RIN_SKIP_EXIT_LOOP=0;;

            --install-source-command        ) optflagcheck "$1" "$OPTFLAG"; OPTFLAGEXIT=$?; local SRC_CLI="$1"; shift;;
            --install-source-packages       ) optflagcheck "$1" "$OPTFLAG"; OPTFLAGEXIT=$?; local SRC_PKG="$1"; shift;;
            --install-source-line-fast-exit ) local SRC_FAST_EXIT_LINE=0;;
            --install-source-line-skip-exit ) local SRC_SKIP_EXIT_LINE=0;;
            --install-source-loop-fast-exit ) local SRC_FAST_EXIT_LOOP=0;;
            --install-source-loop-skip-exit ) local SRC_SKIP_EXIT_LOOP=0;;

            -h | --help ) printf "%s\n" "$MAKEINSTUSAGE"; exit 0;;

            # Process special cases.
            --) while [ "$1" != "$EOL" ]; do set -- "$@" "$1"; shift; done;;                              # Parse remaining as positional.
            --[!=]*=*) set -- "${OPTFLAG%%=*}" "${OPTFLAG#*=}" "$@";;                                     # "--OPTFLAG=arg"  ->  "--OPTFLAG" "arg"
            -[A-Za-z0-9] | -*[!A-Za-z0-9]*) printf >&2 "unknown option: %s\n" "$OPTFLAG"; OPTFLAGEXIT=2;; # Anything invalid like "-*".
            -?*) other="${OPTFLAG#-?}"; set -- "${OPTFLAG%$other}" "-${other}" "$@";;                     # "-abc"  ->  "-a" "-bc"
            *) set -- "$@" "$OPTFLAG";;                                                                   # Positional, rotate to the end.
        esac

        [ "$OPTFLAGEXIT" != 0 ] && break
    done; shift

    [ "$OPTFLAGEXIT" != 0 ] && printf >&2 "%s\n" "$MAKEINSTUSAGE" && exit "$OPTFLAGEXIT"

    local ins_typ_count=0
    [ "$INS_FAST_EXIT_LOOP" = 0 ] && ins_typ_count=$((ins_typ_count+1))
    [ "$INS_SKIP_EXIT_LOOP" = 0 ] && ins_typ_count=$((ins_typ_count+1))
    [ "$INS_FAST_EXIT_LINE" = 0 ] && ins_typ_count=$((ins_typ_count+1))
    [ "$INS_SKIP_EXIT_LINE" = 0 ] && ins_typ_count=$((ins_typ_count+1))
    [ "$ins_typ_count" -gt 1 ] && printf >&2 "error: ambiguous install command type\n" && printf "%s\n" "$MAKEINSTUSAGE" && exit 2

    local rin_typ_count=0
    [ "$RIN_FAST_EXIT_LOOP" = 0 ] && rin_typ_count=$((rin_typ_count+1))
    [ "$RIN_SKIP_EXIT_LOOP" = 0 ] && rin_typ_count=$((rin_typ_count+1))
    [ "$RIN_FAST_EXIT_LINE" = 0 ] && rin_typ_count=$((rin_typ_count+1))
    [ "$RIN_SKIP_EXIT_LINE" = 0 ] && rin_typ_count=$((rin_typ_count+1))
    [ "$rin_typ_count" -gt 1 ] && printf >&2 "error: ambiguous reinstall command type\n" && printf "%s\n" "$MAKEINSTUSAGE" && exit 2

    local uni_typ_count=0
    [ "$UNI_FAST_EXIT_LOOP" = 0 ] && uni_typ_count=$((uni_typ_count+1))
    [ "$UNI_SKIP_EXIT_LOOP" = 0 ] && uni_typ_count=$((uni_typ_count+1))
    [ "$UNI_FAST_EXIT_LINE" = 0 ] && uni_typ_count=$((uni_typ_count+1))
    [ "$UNI_SKIP_EXIT_LINE" = 0 ] && uni_typ_count=$((uni_typ_count+1))
    [ "$uni_typ_count" -gt 1 ] && printf >&2 "error: ambiguous uninstall command type\n" && printf "%s\n" "$MAKEINSTUSAGE" && exit 2

    local src_typ_count=0
    [ "$SRC_FAST_EXIT_LOOP" = 0 ] && src_typ_count=$((src_typ_count+1))
    [ "$SRC_SKIP_EXIT_LOOP" = 0 ] && src_typ_count=$((src_typ_count+1))
    [ "$SRC_FAST_EXIT_LINE" = 0 ] && src_typ_count=$((src_typ_count+1))
    [ "$SRC_SKIP_EXIT_LINE" = 0 ] && src_typ_count=$((src_typ_count+1))
    [ "$src_typ_count" -gt 1 ] && printf >&2 "error: ambiguous source command type\n" && printf "%s\n" "$MAKEINSTUSAGE" && exit 2

    [ "$MAKEINST" != 0 ] && return

    if [ "$uni_typ_count" -eq 1 ] && [ -n "$UNI_CLI" ] && [ -n "$UNI_PKG" ]; then
        OPTFLAGDRYRUN=-1

        if printf "%s" "$UNI_CLI" | grep -q "^[[:space:]]*sudo[[:space:]]"; then
            sudo cat /dev/null || exit 1
        fi

        printf "uninstalling %s ...\n\n" "$DESCRIPTION"

        if [ "$UNI_FAST_EXIT_LOOP" = 0 ]; then for x in ${UNI_PKG}; do $UNI_CLI $x || exit 1; done; fi
        if [ "$UNI_SKIP_EXIT_LOOP" = 0 ]; then for x in ${UNI_PKG}; do $UNI_CLI $x; done; fi
        if [ "$UNI_FAST_EXIT_LINE" = 0 ]; then $UNI_CLI $UNI_PKG || exit 1; fi
        if [ "$UNI_SKIP_EXIT_LINE" = 0 ]; then $UNI_CLI $UNI_PKG; fi

        printf "\n"
    fi

    if [ "$src_typ_count" -eq 1 ] && [ -n "$SRC_CLI" ] && [ -n "$SRC_PKG" ]; then
        OPTFLAGDRYRUN=-1

        if printf "%s" "$SRC_CLI" | grep -q "^[[:space:]]*sudo[[:space:]]"; then
            sudo cat /dev/null || exit 1
        fi

        printf "adding source for %s ...\n\n" "$DESCRIPTION"

        if [ "$SRC_FAST_EXIT_LOOP" = 0 ]; then for x in ${SRC_PKG}; do $SRC_CLI $x || exit 1; done; fi
        if [ "$SRC_SKIP_EXIT_LOOP" = 0 ]; then for x in ${SRC_PKG}; do $SRC_CLI $x; done; fi
        if [ "$SRC_FAST_EXIT_LINE" = 0 ]; then $SRC_CLI $SRC_PKG || exit 1; fi
        if [ "$SRC_SKIP_EXIT_LINE" = 0 ]; then $SRC_CLI $SRC_PKG; fi

        printf "\n"
    fi

    if [ "$ins_typ_count" -eq 1 ] && [ -n "$INS_CLI" ]; then
        OPTFLAGDRYRUN=-1

        if printf "%s" "$INS_CLI" | grep -q "^[[:space:]]*sudo[[:space:]]"; then
            sudo cat /dev/null || exit 1
        fi

        if [ "$OPT_UPDATE" = 0 ]; then
            printf "updating"
        else
            printf "installing"
        fi

        printf " %s ..." "$DESCRIPTION"

        if [ -z "$INS_PKG" ] || [ "$INS_PKG" = " " ]; then
            printf " packages are not provided\n\n"
            return
        fi

        printf "\n\n"

        if [ "$INS_FAST_EXIT_LOOP" = 0 ]; then for x in ${INS_PKG}; do $INS_CLI $x || exit 1; done; fi
        if [ "$INS_SKIP_EXIT_LOOP" = 0 ]; then for x in ${INS_PKG}; do $INS_CLI $x; done; fi
        if [ "$INS_FAST_EXIT_LINE" = 0 ]; then $INS_CLI $INS_PKG || exit 1; fi
        if [ "$INS_SKIP_EXIT_LINE" = 0 ]; then $INS_CLI $INS_PKG; fi

        printf "\n"
    fi

    if [ "$rin_typ_count" -eq 1 ] && [ -n "$RIN_CLI" ]; then
        OPTFLAGDRYRUN=-1

        if printf "%s" "$RIN_CLI" | grep -q "^[[:space:]]*sudo[[:space:]]"; then
            sudo cat /dev/null || exit 1
        fi

        if [ "$OPT_UPDATE" = 0 ]; then
            printf "updating"
        else
            printf "reinstalling"
        fi

        printf " %s ..." "$DESCRIPTION"

        if [ -z "$RIN_PKG" ] || [ "$RIN_PKG" = " " ]; then
            printf " packages are not provided\n\n"
            return
        fi

        printf "\n\n"

        if [ "$RIN_FAST_EXIT_LOOP" = 0 ]; then for x in ${RIN_PKG}; do $RIN_CLI $x || exit 1; done; fi
        if [ "$RIN_SKIP_EXIT_LOOP" = 0 ]; then for x in ${RIN_PKG}; do $RIN_CLI $x; done; fi
        if [ "$RIN_FAST_EXIT_LINE" = 0 ]; then $RIN_CLI $RIN_PKG || exit 1; fi
        if [ "$RIN_SKIP_EXIT_LINE" = 0 ]; then $RIN_CLI $RIN_PKG; fi

        printf "\n"
    fi
}

makeconf () {
    local dir="${1}"

    [ -z "$dir" ] && return

    local usr="$USER"

    case "$dir" in
        "/" | "/etc" ) usr="root";;
        *) usr="$(basename "$dir")";;
    esac

    local dir_hdr="${dir}"
    [ "$dir_hdr" = "/" ] && local dir_hdr="${dir_hdr} root"

    printf "configuring %s directory ...\n\n" "$dir_hdr"

    OPTFLAGDRYRUN=-1
    git -C "$dir" rev-parse || exit 1
    sudo cat /dev/null || exit 1

    if [ $(sudo git -C "$dir" status --porcelain | wc -l) = 0 ]; then
        printf "already configured %s directory\n" "$dir"
    else
        local IFS=$"
"
        for line in $(sudo git -C "$dir" status --porcelain); do
            local mode=$(printf "%s" "$line" | awk '{print $1}')
            local file=$(printf "%s" "$line" | awk '{print $2}')
            local desc=""

            for str in $(sudo git -C "$dir" status "$file" | grep "$file"); do
                if [ "$desc" != "" ]; then
                    desc="${desc} "
                fi
                desc="$desc"$(printf "%s" "$str" | awk '{print $1}' | sed 's/:$//')
            done

            if [ "$mode" = 'D' ]; then
                str=$(printf "restore %s %s %s file?" "$mode" "$desc" "$file")
                while true; do
                    read -p "$str " yn
                    case $yn in
                        [Yy]* ) sudo -u "$usr" git -C "$dir" checkout "$file"; break;;
                        [Nn]* ) break;;
                        * ) printf "please answer yes or no\n";;
                    esac
                done
            elif [ "$mode" = 'M' ]; then
                str=$(printf "restore %s %s %s file?" "$mode" "$desc" "$file")
                sudo git -C "$dir" diff "$file"
                while true; do
                    read -p "$str " yn
                    case $yn in
                        [Yy]* ) sudo -u "$usr" git -C "$dir" checkout "$file"; break;;
                        [Nn]* ) break;;
                        * ) printf "please answer yes or no\n";;
                    esac
                done
            else
                printf "invalid %s state (%s) of %s file\n" "$mode" "$desc" "$file"
            fi
        done
    fi
}

makelock() {
    lock_file="${1}"
    lock_fd="${2}"
    [ ! -x "$(command -v flock)" ] && { printf >&2 "missing flock command\ninstall flock: \`brew install flock\` or \`brew install util-linux\`\n" ; exit 1; } # flock command manages lock from shell scripts.
    eval "exec $lock_fd>$lock_file"
    flock -n "$lock_fd" || { printf "locked makehome"; exit 1; }
}

trap exit INT

makelock "/tmp/makehome.lock" 9
makehome "$@"

# TODO: Use function instead of variable: `PACS_INS_CLI="pacstall --cache-info $1 install_type > /dev/null || pacstall --disable-prompts --install --keep $1"` APTO_INS_CLI BREW_INS_CLI APPM_INS_CLI
