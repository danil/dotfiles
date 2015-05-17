#! /bin/bash
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

cd /var/git/dotfiles.git
git push --mirror gitlab
git push --mirror github
git push --mirror bitbucket
