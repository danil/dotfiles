#! /bin/bash
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

function my-mirror-for {
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

# my-mirror-for "cv.git"                       "gitlab github" "gh-pages"
# my-mirror-for "go/client-server-example.git" "github"             "master"
# my-mirror-for "go/count-words-server-example.git" "github"        "master"
# my-mirror-for "go/ptichka.git"               "gitlab github"      "master"
my-mirror-for "dotfiles-playbooks.git"       "github"        "master"
my-mirror-for "dotfiles.git"                 "gitlab github" "h2-gentoo-danil h10-gentoo-danil h4-sailfish-nemo"
my-mirror-for "el/ferm-mode.git"             "gitlab github" "master"
my-mirror-for "el/ido-describe-bindings.git" "gitlab github" "master"
my-mirror-for "el/ido-occur.git"             "gitlab github" "master"
my-mirror-for "el/init.el.git"               "gitlab github" "master trash"
my-mirror-for "etc.git"                      "gitlab github" "h2-gentoo h10-gentoo h4-sailfish"
my-mirror-for "go/count-word-in-urls-example.git" "github"   "master"
my-mirror-for "go/csv_aggregate_example.git" "github"        "master"
my-mirror-for "js/homepage.git"              "gitlab github" "master"
my-mirror-for "kernels.git"                  "gitlab github" "h10-gentoo"
my-mirror-for "keys.git"                     "gitlab github" "master"
my-mirror-for "lua/imapfilters.git"          "github"        "master"
my-mirror-for "md/rc.git"                    "gitlab github" "master"
my-mirror-for "sh/overlays.git"              "gitlab github" "master net-analyzer/linode-longview sys-apps/mdp unsupported"
my-mirror-for "sieves.git"                   "gitlab github" "master"
my-mirror-for "utils.git"                    "gitlab github" "master"
my-mirror-for "worlds.git"                   "gitlab github" "h2 h10"
my-mirror-for "zones.git"                    "gitlab github" "master"
