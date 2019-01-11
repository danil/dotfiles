#! /bin/bash
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

function my-mirror-private {
    local name=$1
    local vendors=$2
    local branches=$3
    cd $(eval echo '~danil')/git/$name
    for vendor in $vendors; do
        git push --quiet --tags $vendor $branches
    done
}

my-mirror-private "defts.git"        "github" "master"
my-mirror-private "errocketbank.git" "github" "master"
