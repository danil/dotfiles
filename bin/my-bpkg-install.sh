#!/bin/sh

my_install='bpkg install'

bpkg update
rm ~/deps/bin/*

$my_install bpkg/sha1dir #get the sha1 of a directory
$my_install sstephenson/bats #bash automated testing system <https://github.com/sstephenson/bats>
$my_install rauchg/spot #file search utility <https://github.com/rauchg/spot>
PREFIX=$HOME $my_install rylnd/shpec #test shell scripts <https://github.com/rylnd/shpec>
