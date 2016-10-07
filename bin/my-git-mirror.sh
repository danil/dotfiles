#! /bin/bash
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

function my-mirror-for {
    local name=$1
    local vendors=$2
    local branches=$3

    cd /var/git/$name

    # <http://stackoverflow.com/questions/1469849/how-to-split-one-string-into-multiple-strings-separated-by-at-least-one-space-in#1469863>,
    # <http://unix.stackexchange.com/questions/47557/in-a-bash-shell-script-writing-a-for-loop-that-iterates-over-string-values#47560>,
    # <http://stackoverflow.com/questions/17249665/splitting-a-comma-separated-string-into-multiple-words-so-that-i-can-loop-throug#17249721>.
    for vendor in $vendors; do
        git push --quiet --tags $vendor $branches
    done
}

my-mirror-for "cv.git"                       "gitlab github" "gh-pages"
my-mirror-for "dotfiles-playbooks.git"       "github" "master"
my-mirror-for "dotfiles.git"                 "gitlab gogs github" "h2-gentoo-danil h10-gentoo-danil h4-sailfish-nemo"
my-mirror-for "el/ferm-mode.git"             "gitlab gogs github" "master"
my-mirror-for "el/ido-describe-bindings.git" "gitlab gogs github" "master"
my-mirror-for "el/ido-occur.git"             "gitlab gogs github" "master"
my-mirror-for "el/init.el.git"               "gitlab gogs github" "master trash"
my-mirror-for "etc.git"                      "gitlab gogs github" "h2-gentoo h10-gentoo h4-sailfish"
my-mirror-for "go/client-server-example.git" "github"             "master"
my-mirror-for "go/jsonapi-sqlite-readonly-example.git" "github"   "master"
my-mirror-for "go/ptichka.git"               "gitlab github"      "master"
my-mirror-for "js/homepage.git"              "gitlab gogs github" "master"
my-mirror-for "kernels.git"                  "gitlab gogs github" "h10-gentoo"
my-mirror-for "keys.git"                     "gitlab gogs github" "master"
my-mirror-for "md/rc.git"                    "gitlab gogs github" "master"
my-mirror-for "sh/overlays.git"              "gitlab gogs github" "master net-analyzer/linode-longview sys-apps/mdp unsupported"
my-mirror-for "sieves.git"                   "gitlab gogs github" "master"
my-mirror-for "utils.git"                    "gitlab github" "master"
my-mirror-for "worlds.git"                   "gitlab gogs github" "h2 h10"
my-mirror-for "zones.git"                    "gitlab gogs github" "master"
