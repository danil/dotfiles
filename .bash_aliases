# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_TYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Tab completion
# <http://wiki.gentoo.org/wiki/Bash#Tab_completion>.
[[ -f /etc/profile.d/bash-completion.sh ]] && source /etc/profile.d/bash-completion.sh

# Disable the XOFF (Ctrl-s) keystroke
# <http://superuser.com/questions/124845/can-you-disable-the-ctrl-s-xoff-keystroke-in-putty#155875>,
# <https://wiki.archlinux.org/index.php/Readline#History>.
stty -ixon

export TERMINAL="xterm" #safe fallback/backup terminal
export EDITOR="vim" #export EDITOR="/usr/bin/emacsclient -t" #safe fallback/backup editor
# export ALTERNATE_EDITOR="/usr/bin/emacs"
export GIT_EDITOR='emacs'
# export PAGER="/usr/bin/less --IGNORE-CASE --LONG-PROMPT" #not working(
export HISTSIZE=50000
export HISTFILESIZE=50000
export HISTCONTROL=ignoredups:erasedups
# See /usr/share/terminfo/*/
# export TERM=rxvt-256color
[ "$TERM" = "xterm" ] && TERM="xterm-256color" #<http://ricochen.wordpress.com/2011/07/23/mac-os-x-lion-terminal-color-remote-access-problem-fix>
#export GIT_PAGER=""

# Aliases.
# <http://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo#22043>.
alias sudo='sudo '
alias ls='ls --color'
alias ll='ls -l --all --human-readable'
# alias less=$PAGER
alias e='emacs --no-window-system'
alias ec='emacsclient --tty'
alias ag='ag --width=5000'

export PATH="$HOME"/bin:"$PATH" #clib c package manager installs here <https://github.com/clibs/clib> run `c-install-all`
export PATH="$HOME"/sbin:"$PATH"
export PATH="$HOME"/.cask/bin:"$PATH" #emacs cask <http://cask.github.io>
export PATH="$HOME"/.local/bin:"$PATH" #tmux make installs here and pip (python package management system) run `python-install-all`
export PATH="$HOME"/.local/sbin:"$PATH" #powertop make installs here
export PATH="$HOME"/.local/usr/bin:"$PATH" #xxkb make installs here
export PATH="$HOME"/.local/usr/local/bin:"$PATH" #dwm make installs here
export PATH="$HOME"/deps/bin:"$PATH" #bpkg bash package manager <https://github.com/bpkg/bpkg#installing-packages> run `bash-install-all`

[ -f "$HOME"/.netrc/.netrc ] && export NETRC="$HOME"/.netrc/.netrc

# <https://askubuntu.com/questions/210210/pkg-config-path-environment-variable#210235>.
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH":/usr/lib/pkgconfig
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH":/usr/lib/x86_64-linux-gnu/pkgconfig
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH":/usr/share/pkgconfig

# Basher is a bash/shell/functions package manager
# <https://github.com/basherpm/basher>.
if hash basher 2>/dev/null; then
    export PATH="$HOME/.basher/bin:$PATH"
    eval "$(basher init - bash)"
fi

# Homebrew
[ -f /home/linuxbrew/.linuxbrew/bin/brew ] && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# Debian/Ubuntu
export DEBFULLNAME="Danil Kutkevich"
export DEBEMAIL="danil@kutkevich.org"

# Go <http://golang.org/doc/code.html#GOPATH>.
# Run `go-install-all`.
export GOPATH="$HOME"/go
export PATH="$PATH":/usr/lib/go-1.12/bin #ubuntu go 12
export PATH="$PATH":"$GOPATH"/bin #for convenience, add the workspace's bin subdirectory to your PATH
# export PATH="$PATH:$(go env GOPATH)/bin"
# [[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm" #gvm (Go version manager) <https://github.com/moovweb/gvm>

# rbenv <https://github.com/sstephenson/rbenv#basic-github-checkout>.
export PATH="$HOME/.rbenv/bin:$PATH"
if hash rbenv 2>/dev/null; then
    eval "$(rbenv init -)"
fi

# Travis CI gem.
[ -f "$HOME"/.travis/travis.sh ] && source "$HOME"/.travis/travis.sh #auto completion

# Node.js and npm.
# WARNING: Do NOT give priority to npm executables!!!
export PATH="$PATH:$HOME/node_modules/.bin"

# n (Node.js version manager).
# Added by n-install (see http://git.io/n-install-repo).
export N_PREFIX="$HOME"
[[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"

# # nvm (Node.js version manager)
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  #this loads nvm
# [[ -r "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"

# PHP Composer.
export COMPOSER_PREFIX="$HOME/vendor"
[[ :$PATH: == *":$COMPOSER_PREFIX/bin:"* ]] || PATH+=":$COMPOSER_PREFIX/bin"

# # Lua.
# PATH="$HOME"/.luarocks/bin:"$PATH"
# export LUA_PATH="$HOME""/.luarocks/share/lua/5.1//?.lua;./?.lua;$LUA_PATH"
# export LUA_CPATH="$HOME""/.luarocks/lib/lua/5.1//?.so;./?.so;$LUA_CPATH"

# # lenv (Lua version manager) <https://github.com/mah0x211/lenv>.
# export PATH="$HOME"/.lenv/bin:"$HOME"/.lenv/current/bin:$PATH
# export LUA_PATH="$HOME"'/.lenv/current/luarocks/share/?.lua;'"$HOME"'/.lenv/current/luarocks/share/?/init.lua;;'
# export LUA_CPATH="$HOME"'/.lenv/current/luarocks/lib/?.so;;'

# Rust (rust toolchain installer https://rustup.rs).
[ -f "$HOME"/.cargo/env ] && source "$HOME"/.cargo/env # adding `"$HOME"/.cargo/bin` to your PATH to be able to run the installed binaries

# Dart <https://dart.dev/get-dart>.
export PATH="$PATH:/usr/lib/dart/bin"

# # Steel Bank Common Lisp.
# export SBCL_HOME=/usr/lib64/sbcl

# Updates PATH for Yandex Cloud CLI.
if [ -f "$HOME"/yandex-cloud/path.bash.inc ]; then source "$HOME"/yandex-cloud/path.bash.inc; fi
# Enables shell command completion for yc (Yandex Cloud).
if [ -f "$HOME"/yandex-cloud/completion.bash.inc ]; then source "$HOME"/yandex-cloud/completion.bash.inc; fi

# # Prompt powerline-go.
# function wm_notify_last_command {
#     local previous_command=$1
#     local previous_errcode=$2
#     local previous_seconds=$3
#     # Interactive commands.
#     case $previous_command in
#         alsamixer*) return 0 ;;
#         emacs*|sudo?emacs*) return 0 ;;
#         git*log*|sudo?git*log*|git*rebase*|sudo?git*rebase*) return 0 ;;
#         htop*|sudo?htop*) return 0 ;;
#         less*|sudo?less*) return 0 ;;
#         make*menuconfig*|sudo?make*menuconfig*) return 0 ;;
#         tmux*|sudo?tmux) return 0 ;;
#         vim*|sudo?vim*) return 0 ;;
#         lftp*) return 0 ;;
#         mosh*) return 0 ;;
#         mongo*) return 0 ;;
#     esac
#     command -v dunstify >/dev/null 2>&1 || return 0
#     if [[ ${previous_seconds} -lt 1 ]]; then # too fast command
#         return 0
#     fi
#     notify_title="${previous_seconds}s" # ◷
#     # <http://tldp.org/LDP/abs/html/exitcodes.html>.
#     case $__ERRCODE in
#         0)
#             # low, normal, critical.
#             my_notify_urgency="low"
#             ;;
#         *)
#             my_notify_urgency="critical"
#             notify_title="${previous_errcode}! $__DURATION" # ☢
#             ;;
#     esac
#     dunstify --urgency=$my_notify_urgency "$notify_title" "$previous_command"
# }
# INTERACTIVE_BASHPID_TIMER="/tmp/${USER}.START.$$"
# PS0='$(echo $SECONDS > "$INTERACTIVE_BASHPID_TIMER")'
# function _update_ps1() {
#     local __ERRCODE=$?
#     local __DURATION=0
#     if [ -e $INTERACTIVE_BASHPID_TIMER ]; then
#         local __END=$SECONDS
#         local __START=$(cat "$INTERACTIVE_BASHPID_TIMER")
#         __DURATION="$(($__END - ${__START:-__END}))"
#         rm -f "$INTERACTIVE_BASHPID_TIMER"
#     fi
#     # aws,cwd,docker,dotenv,exit,git,gitlite,hg,host,jobs,load,nix-shell,perlbrew,perms,root,shell-var,ssh,termtitle,time,user,venv,node
#     modules=""
#     modules+="venv"
#     modules+=",user"
#     modules+=",host"
#     modules+=",ssh"
#     modules+=",cwd"
#     modules+=",perms"
#     modules+=",git"
#     modules+=",jobs"
#     modules+=",exit"
#     modules+=",root"
#     args=()
#     args+=( " -mode flat" )
#     args+=( " -newline" )
#     args+=( " -error $__ERRCODE" )
#     args+=( " -numeric-exit-codes" )
#     args+=( " -shell bash" )
#     args+=( " -colorize-hostname" )
#     if [[ ${__DURATION} -gt 2 ]] ; then
#         modules+=",duration"
#         args+=( " -duration $__DURATION" )
#     fi
#     args+=( " -modules ${modules[@]}" )
#     PS1="$(powerline-go ${args[@]})"
#     wm_notify_last_command "$previous_command" "$__ERRCODE" "$__DURATION"
# }
# trap 'previous_command=$this_command; this_command=$BASH_COMMAND' DEBUG
# if [ "$TERM" != "linux" ]; then
#     PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
# fi
# Prompt.
# function _update_ps1() {
#     PS1="$(~/go/bin/powerline-go -error $?)"
# }
# if [ "$TERM" != "linux" ]; then
#     PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
# fi
[[ -f "$HOME"/.bash_prompt.sh ]] && source "$HOME"/.bash_prompt.sh
