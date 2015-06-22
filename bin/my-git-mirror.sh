#! /bin/bash
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

my_mirror_command="git push --quiet"
my_mirror_vendors=(
    "gitlab"
    "gogs"
    "github"
    "bitbucket"
)

function my-mirror-for {
    local name=${1}
    local branches=${2}

    cd /var/git/$name

    for vendor in "${my_mirror_vendors[@]}"
    do
        $my_mirror_command ${vendor} ${branches}
    done
}

my-mirror-for "dotfiles.git" "h10-gentoo-danil h2-gentoo-danil h3-arch-danil h3-gentoo-danil h4-sailfish-nemo h5-ubuntu-danil h6-gentoo-danil h7-ubuntu-medapp h9-gentoo-danil hl7rus-ubuntu-danil homer-gentoo-danil jobtest_molinos_ru lisa-gentoo-danil"
my-mirror-for "el/init.el.git" "h10-gentoo-danil h2-gentoo-danil h3-gentoo-danil h5-ubuntu-danil h6-gentoo-danil h9-gentoo-danil"
my-mirror-for "etc.git" "h10-gentoo h2-gentoo h3-arch h3-gentoo h4-sailfish h5-ubuntu h6-gentoo h9-gentoo homer-gentoo lisa-gentoo"
my-mirror-for "grubs.git" "h3-gentoo h6-gentoo h8-gentoo homer-gentoo"
my-mirror-for "js/homepage.git" "master"
my-mirror-for "kernels.git" "h10-gentoo h3-gentoo h6-gentoo h8-gentoo h9-gentoo"
my-mirror-for "keys.git" "master"
my-mirror-for "md/rc.git" "master"
my-mirror-for "sh/overlays.git" "master net-analyzer/linode-longview sys-apps/mdp unsupported"
my-mirror-for "sieves.git" "master"
my-mirror-for "worlds.git" "h10 h2 h3 h6 h8 h9 homer"
my-mirror-for "zones.git" "master"
