#!/bin/bash

dir=${dir:-./}
cmd="rsync --rsh 'ssh -p 22022' --checksum --human-readable --archive --partial --progress --stats"
url="danil@staging.armor5games.com"
dateprefix1=$(date --utc +%Y-%m-%d)
dateprefix2=$(date --utc +%Y%m%d)

while [ $# -gt 0 ]; do
    case "$1" in
        --directory=*)
            dir="${1#*=}"
            ;;
        *)
            printf "***************************\n"
            printf "* Error: Invalid argument.*\n"
            printf "***************************\n"
            exit 1
    esac
    shift
done

if [ ! -d $dir ]; then
    echo "rop: failed to backup to '$dir': No such directory" 1>&2
    exit 1
fi

if ! command -v rsync >/dev/null 2>&1; then
    # <http://en.wikipedia.org/wiki/Nohup#Overcoming_hanging>.
    echo "rop: rsync: command not found" 1>&2
    exit 1

fi

file=social.zip-${dateprefix2}
echo === $file ===
eval "$cmd ${url}:/var/social_backups/${dateprefix1}-backup.zip $dir/$file"

file=social_maindb.zip-${dateprefix2}
printf "\n"
echo === $file ===
eval "$cmd ${url}:/var/social_backups/${dateprefix1}-maindb.zip $dir/$file"

file=flintvk.zip-${dateprefix2}
printf "\n"
echo === $file ===
eval "$cmd ${url}:/var/flintvk_backups/${dateprefix1}-backup.zip $dir/$file"

file=ropshard1_shard.zip-${dateprefix2}
printf "\n"
echo === $file ===
eval "$cmd ${url}:/var/ropshard1_backups/${dateprefix1}-shard.zip $dir/$file"

file=ropshard1_sharddb.zip-${dateprefix2}
printf "\n"
echo === $file ===
eval "$cmd ${url}:/var/ropshard1_backups/${dateprefix1}-sharddb.zip $dir/$file"
