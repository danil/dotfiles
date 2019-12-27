#! /bin/bash
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

function my-mirror-public {
    local name=$1
    local vendors=$2
    local branches=$3
    cd $(eval echo '~git')/$name
    # <http://stackoverflow.com/questions/1469849/how-to-split-one-string-into-multiple-strings-separated-by-at-least-one-space-in#1469863>,
    # <http://unix.stackexchange.com/questions/47557/in-a-bash-shell-script-writing-a-for-loop-that-iterates-over-string-values#47560>,
    # <http://stackoverflow.com/questions/17249665/splitting-a-comma-separated-string-into-multiple-words-so-that-i-can-loop-throug#17249721>.
    for vendor in $vendors; do
        git push --quiet --tags $vendor $branches
    done
}

# my-mirror-public "cv.git"                       "gitlab github" "gh-pages"
# my-mirror-public "go/client-server-example.git" "github"             "master"
# my-mirror-public "go/count-words-server-example.git" "github"        "master"
# my-mirror-public "go/ptichka.git"               "gitlab github"      "master"
my-mirror-public "debsrc/dwm.git"               "github"        "bionic"
my-mirror-public "debsrc/stterm.git"            "github"        "bionic"
my-mirror-public "dotfiles-playbooks.git"       "github"        "master"
my-mirror-public "dotfiles.git"                 "gitlab github" "h2-gentoo-danil h10-gentoo-danil h17-ubuntu-danil h18-termux-danil h19-ubuntu-danil"
my-mirror-public "el/ferm-mode.git"             "gitlab github" "master"
my-mirror-public "el/ido-describe-bindings.git" "gitlab github" "master"
my-mirror-public "el/ido-occur.git"             "gitlab github" "master"
my-mirror-public "el/init.el.git"               "gitlab github" "master trash"
my-mirror-public "etc.git"                      "gitlab github" "h2-gentoo h10-gentoo h4-sailfish h19-ubuntu"
my-mirror-public "example.git"                  "bitbucket"     "a c b10"
my-mirror-public "go/csv_aggregate_example.git" "github"        "master"
my-mirror-public "go/merge_two_files_example.git" "github"      "master"
my-mirror-public "go/mutex_vs_channels_benchmark.git" "github"  "master"
# my-mirror-public "go/plainstatus.git"           "github"        "master"
my-mirror-public "go/rsa_signature_example.git" "github"     "master"
my-mirror-public "js/homepage.git"              "gitlab github" "master"
my-mirror-public "kernels.git"                  "gitlab github" "h10-gentoo"
my-mirror-public "keys.git"                     "gitlab github" "master"
my-mirror-public "lua/imapfilters.git"          "github"        "master"
my-mirror-public "md/rc.git"                    "gitlab github" "master"
my-mirror-public "md/rcc.git"                   "github"        "master"
my-mirror-public "sh/overlays.git"              "gitlab github" "master net-analyzer/linode-longview sys-apps/mdp unsupported"
my-mirror-public "sh/rsa_signature_example.git" "bitbucket"     "master"
my-mirror-public "sieves.git"                   "gitlab github" "master"
my-mirror-public "suckless/dmenu.git"           "github"       "master"
my-mirror-public "suckless/dwm.git"             "github"        "master"
my-mirror-public "suckless/slstatus.git"        "github"        "master"
my-mirror-public "usr.git"                      "github"        "h10-ubuntu h19-ubuntu"
my-mirror-public "utils.git"                    "gitlab github" "master"
my-mirror-public "worlds.git"                   "gitlab github" "h2 h10"
my-mirror-public "zones.git"                    "gitlab github" "master"
