#! /bin/bash
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

my_mirror_push_command="git push --quiet --tags"

function my-mirror-for {
    local name=$1
    local vendors=$2
    local branches=$3

    cd /var/git/$name

    # <http://stackoverflow.com/questions/1469849/how-to-split-one-string-into-multiple-strings-separated-by-at-least-one-space-in#1469863>,
    # <http://unix.stackexchange.com/questions/47557/in-a-bash-shell-script-writing-a-for-loop-that-iterates-over-string-values#47560>,
    # <http://stackoverflow.com/questions/17249665/splitting-a-comma-separated-string-into-multiple-words-so-that-i-can-loop-throug#17249721>.
    for vendor in $vendors; do
        $my_mirror_push_command $vendor $branches
    done
}

my-mirror-for "dotfiles.git"                 "gitlab gogs github" "h11-gentoo-danil h2-gentoo-danil h4-sailfish-nemo h5-ubuntu-danil"
my-mirror-for "el/ferm-mode.git"             "gitlab gogs github" "master"
my-mirror-for "el/ido-describe-bindings.git" "gitlab gogs github" "master"
my-mirror-for "el/ido-occur.git"             "gitlab gogs github" "master"
my-mirror-for "el/init.el.git"               "gitlab gogs github" "master trash"
my-mirror-for "etc.git"                      "gitlab gogs github" "h11-gentoo h2-gentoo h4-sailfish h5-ubuntu"
my-mirror-for "go/tgtm.git"                  "gitlab github"      "master"
my-mirror-for "js/homepage.git"              "gitlab gogs github" "master"
my-mirror-for "kernels.git"                  "gitlab gogs github" "h11-gentoo"
my-mirror-for "keys.git"                     "gitlab gogs github" "master"
my-mirror-for "md/rc.git"                    "gitlab gogs github" "master"
my-mirror-for "sh/overlays.git"              "gitlab gogs github" "master net-analyzer/linode-longview sys-apps/mdp unsupported"
my-mirror-for "sieves.git"                   "gitlab gogs github" "master"
my-mirror-for "worlds.git"                   "gitlab gogs github" "h11 h2"
my-mirror-for "zones.git"                    "gitlab gogs github" "master"
