#! /bin/bash
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

oldversion="$(git describe --abbrev=0 --tags 2>/dev/null)"
if [ -z "$oldversion" ] || [ "$oldversion" = "" ]; then
    echo "fatal: the old version is unknown"
    exit 1
fi

while [ $# -gt 0 ]; do
    case "$1" in
        --newversion=*)
            newversion="${1#*=}"
            ;;
        --sources=*)
            sources="${1#*=}"
            ;;
        *)
            printf "***************************\n"
            printf "* Error: Invalid argument.*\n"
            printf "***************************\n"
            exit 1
    esac
    shift
done

file="$0"
if [ ! -z "$HOME" ] && [ "$HOME" != "" ]; then
    file="${file/$HOME/\~}"
fi

usage="Usage: $file"
usage="$usage --newversion=\"$oldversion\""
usage="$usage --sources=\"first/file second/file\""

if [ -z "$newversion" ] || [ "$newversion" = "" ]; then
    echo "$usage"
    exit 1
fi

if [ -z "$sources" ] || [ "$sources" = "" ]; then
    echo "$usage"
    exit 1
fi

for file in $sources; do
    sed --in-place --expression="s/$oldversion/$newversion/g" "$file" || exit 1
done
