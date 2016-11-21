#!/bin/bash

dir=${dir:-./}
cmd="rsync --rsh 'ssh -p 22022' --checksum --human-readable --archive --partial --progress --stats"
url="danil@78.46.51.206"
dateprefix1=$(date --utc +%Y-%m-%d)
dateprefix2=$(date --utc +%Y%m%dZ)

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

file=social_${dateprefix2}.zip
echo === $file ===
eval "$cmd ${url}:/var/social_backups/${dateprefix1}-backup.zip $dir/$file"

file=social_maindb_${dateprefix2}.zip
printf "\n"
echo === $file ===
eval "$cmd ${url}:/var/social_backups/${dateprefix1}-maindb.zip $dir/$file"

file=flintvk_${dateprefix2}.zip
printf "\n"
echo === $file ===
eval "$cmd ${url}:/var/flintvk_backups/${dateprefix1}-backup.zip $dir/$file"

file=ropshard1_shard_${dateprefix2}.zip
printf "\n"
echo === $file ===
eval "$cmd ${url}:/var/ropshard1_backups/${dateprefix1}-shard.zip $dir/$file"

file=ropshard1_sharddb_${dateprefix2}.zip
printf "\n"
echo === $file ===
eval "$cmd ${url}:/var/ropshard1_backups/${dateprefix1}-sharddb.zip $dir/$file"

# mkdir -p /home/danil/backups/social/
# mkdir -p /home/danil/backups/vseguru/
# mkdir -p /home/danil/backups/flintvk/
# mkdir -p /home/danil/backups/shard1/

# scp -P 22022 \
#     danil@78.46.51.206:/var/social_backups/`date +%Y-%m-%d`-backup.zip \
#     /home/danil/backups/social

# scp -P 22022 \
#     danil@78.46.51.206:/var/social_backups/`date +%Y-%m-%d`-maindb.zip \
#     /home/danil/backups/social

# scp -P 22022 \
#     danil@78.46.51.206:/var/flintvk_backups/`date +%Y-%m-%d`-backup.zip \
#     /home/danil/backups/flintvk

# # scp -P 22022 \
# #     danil@78.46.51.206:/var/vseguru_backups/`date +%Y-%m-%d`-backup.zip \
# #     /home/danil/backups/vseguru

# scp -P 22022 \
#     danil@78.46.51.206:/var/ropshard1_backups/`date +%Y-%m-%d`-shard.zip \
#     /home/danil/backups/shard1

# scp -P 22022 \
#     danil@78.46.51.206:/var/ropshard1_backups/`date +%Y-%m-%d`-sharddb.zip \
#     /home/danil/backups/shard1

# find /home/danil/backups/social -name "*.zip" -mtime +10 -delete
# find /home/danil/backups/shard1 -name "*.zip" -mtime +10 -delete
# find /home/danil/backups/flintvk -name "*.zip" -mtime +10 -delete
