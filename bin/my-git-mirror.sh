#! /bin/bash
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

my_mirror_push_command="git push --quiet --tags"

# "bitbucket"
# "github"
# "gitlab"
# "gogs"
my_mirror_vendors=(
    "gitlab"
    "github"
)

function my-mirror-for {
    local name=${1}
    local branches=${2}

    cd /var/git/$name

    for vendor in "${my_mirror_vendors[@]}"
    do
        $my_mirror_push_command ${vendor} ${branches}
    done
}

my-mirror-for "dotfiles.git" "h2-gentoo-danil h11-gentoo-danil h4-sailfish-nemo h5-ubuntu-danil"
my-mirror-for "el/ferm-mode.git" "master"
my-mirror-for "el/ido-describe-bindings.git" "master"
my-mirror-for "el/ido-occur.git" "master"
my-mirror-for "el/init.el.git" "master trash"
my-mirror-for "etc.git" "h2-gentoo h11-gentoo h4-sailfish h5-ubuntu"
my-mirror-for "go/tgtm.git" "master"
my-mirror-for "grubs.git" "h3-gentoo h6-gentoo h8-gentoo homer-gentoo"
my-mirror-for "js/homepage.git" "master"
my-mirror-for "kernels.git" "h11-gentoo"
my-mirror-for "keys.git" "master"
my-mirror-for "md/rc.git" "master"
my-mirror-for "sh/overlays.git" "master net-analyzer/linode-longview sys-apps/mdp unsupported"
my-mirror-for "sieves.git" "master"
my-mirror-for "worlds.git" "h2 h11"
my-mirror-for "zones.git" "master"
