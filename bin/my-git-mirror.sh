#! /bin/bash
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

function my-mirror-for {
    local name=${1}
    cd /var/git/$name
    git push --mirror gitlab
    git push --mirror github
    git push --mirror bitbucket
}

my-mirror-for "dotfiles.git"
my-mirror-for "init.el.git"
