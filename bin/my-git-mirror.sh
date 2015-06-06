#! /bin/bash
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

my_mirror_command="git push --quiet --mirror"

function my-mirror-for {
    local name=${1}
    cd /var/git/$name
    $my_mirror_command gitlab
    $my_mirror_command gogs
    $my_mirror_command github
    $my_mirror_command bitbucket
}

my-mirror-for "dotfiles.git"
my-mirror-for "init.el.git"
