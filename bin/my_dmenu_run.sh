#!/bin/sh

# prompt="$USER@`hostname`"
# dmenu -p $prompt

command="/home/danil/.local/usr/local/bin/dmenu"

number_of_lines=${number_of_lines:-1}

while [ $# -gt 0 ]; do
    case "$1" in
        --lines=*)
            let number_of_lines="${1#*=}"
            ;;
        *)
            printf "***************************\n"
            printf "* Error: Invalid argument.*\n"
            printf "***************************\n"
            exit 1
    esac
    shift
done

[[ $number_of_lines -gt 1 ]] && command="$command -l $number_of_lines"

# <http://tools.suckless.org/dmenu/scripts/dmenu_run_with_command_history>

cachedir=${XDG_CACHE_HOME:-"$HOME/.cache"}
if [ -d "$cachedir" ]; then
  cache=$cachedir/dmenu_run
  historyfile=$cachedir/dmenu_history
else      # if no xdg dir, fall back to dotfiles in ~
  cache=$HOME/.dmenu_cache
  historyfile=$HOME/.dmenu_history
fi

IFS=:
if stest -dqr -n "$cache" $PATH; then
  stest -flx $PATH | sort -u > "$cache"
fi
unset IFS

awk -v histfile=$historyfile '
	BEGIN {
		while( (getline < histfile) > 0 ) {
			sub("^[0-9]+\t","")
			print
			x[$0]=1
		}
	} !x[$0]++ ' "$cache" \
	| $command "$@" \
	| awk -v histfile=$historyfile '
		BEGIN {
			FS=OFS="\t"
			while ( (getline < histfile) > 0 ) {
				count=$1
				sub("^[0-9]+\t","")
				fname=$0
				history[fname]=count
			}
			close(histfile)
		}

		{
			history[$0]++
			print
		}

		END {
			if(!NR) exit
			for (f in history)
				print history[f],f | "sort -t '\t' -k1rn >" histfile
		}
	' \
	| while read cmd; do ${SHELL:-"/bin/sh"} -c "$cmd" & done
