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
my-mirror-for "init.el.git" "h10-gentoo-danil h2-gentoo-danil h3-gentoo-danil h5-ubuntu-danil h6-gentoo-danil h9-gentoo-danil"
