#!/bin/bash

dir=${dir:-./}
cmd="rsync --rsh 'ssh -p 22022' --checksum --human-readable --archive --partial --progress --stats"
url="danil@staging.armor5games.com"
urldate=$(date --utc +%Y-%m-%d)
filedate=$(date --utc +%Y%m%d)

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

file=social.zip-${filedate}
echo === $file ===
eval "$cmd ${url}:/var/social_backups/${urldate}-backup.zip $dir/$file"

file=social_maindb.zip-${filedate}
printf "\n"
echo === $file ===
eval "$cmd ${url}:/var/social_backups/${urldate}-maindb.zip $dir/$file"

file=flintvk.zip-${filedate}
printf "\n"
echo === $file ===
eval "$cmd ${url}:/var/flintvk_backups/${urldate}-backup.zip $dir/$file"

file=ropshard1_shard.zip-${filedate}
printf "\n"
echo === $file ===
eval "$cmd ${url}:/var/ropshard1_backups/${urldate}-shard.zip $dir/$file"

file=ropshard1_sharddb.zip-${filedate}
printf "\n"
echo === $file ===
eval "$cmd ${url}:/var/ropshard1_backups/${urldate}-sharddb.zip $dir/$file"
