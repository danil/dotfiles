# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_TYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Tab completion
# <https://wiki.archlinux.org/title/bash#Common_programs_and_options>.
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -x "$(command -v brew)" ] && [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  elif [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Disable the XOFF (Ctrl-s) keystroke
# <http://superuser.com/questions/124845/can-you-disable-the-ctrl-s-xoff-keystroke-in-putty#155875>,
# <https://wiki.archlinux.org/index.php/Readline#History>.
stty -ixon

export TERMINAL="xterm-256color" # "xterm" #safe fallback/backup terminal

# export ALTERNATE_EDITOR="/usr/bin/emacs"
# export PAGER="/usr/bin/less --IGNORE-CASE --LONG-PROMPT" #not working(
export HISTSIZE=50000
export HISTFILESIZE=50000
export HISTCONTROL=ignoredups:erasedups
# See /usr/share/terminfo/*/
# export TERM=rxvt-256color
[ "$TERM" = "xterm" ] && TERM="xterm-256color" #<http://ricochen.wordpress.com/2011/07/23/mac-os-x-lion-terminal-color-remote-access-problem-fix>
#export GIT_PAGER=""

if [ -x "$(command -v vim)" ]; then
    export EDITOR="vim" #export EDITOR="/usr/bin/emacsclient -t" #safe fallback/backup editor
fi

if [ -x "$(command -v emacs)" ]; then
    export GIT_EDITOR='emacs'
fi

# Aliases.
# <http://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo#22043>.
alias sudo='sudo '
alias ls='ls --color'
# alias less=$PAGER
alias ag='ag --width=5000'

export PATH="$HOME"/.local/bin:"$PATH" #tmux make installs here and pip (python package management system) run `python-install-all`
export PATH="$HOME"/.local/sbin:"$PATH"
export PATH="$HOME"/.local/usr/bin:"$PATH" #xxkb make installs here
export PATH="$HOME"/.local/usr/sbin:"$PATH" #powertop make installs here
export PATH="$HOME"/.local/usr/local/bin:"$PATH" #dwm make installs here
export PATH="$HOME"/.local/usr/local/sbin:"$PATH" #dwm make installs here
export PATH="$HOME"/sbin:"$PATH"
export PATH="$HOME"/bin:"$PATH" #clib c package manager installs here <https://github.com/clibs/clib> run `c-install-all`
export PATH="$HOME"/deps/bin:"$PATH" #bpkg bash package manager <https://github.com/bpkg/bpkg#installing-packages> run `bash-install-all`
export PATH="$HOME"/.cask/bin:"$PATH" #emacs cask <http://cask.github.io>

export MANPATH="$HOME"/.local/usr/share/man:"$MANPATH"
export MANPATH="$HOME"/.local/usr/local/share/man:"$MANPATH"

[ -f "$HOME"/.netrc/.netrc ] && export NETRC="$HOME"/.netrc/.netrc

# <https://askubuntu.com/questions/210210/pkg-config-path-environment-variable#210235>.
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH":/usr/lib/pkgconfig
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH":/usr/lib/x86_64-linux-gnu/pkgconfig
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH":/usr/share/pkgconfig

export CHROME_PATH="${CHROME_PATH:-/home/danil/bin/chrome}"

# bc calculator
# <https://askubuntu.com/questions/621017/how-to-set-default-scale-for-bc-calculator#939407>.
export BC_ENV_ARGS=/home/danil/.bc

# Basher is a bash/shell/functions package manager
# <https://github.com/basherpm/basher>.
if [ -x "$(command -v basher)" ]; then
    export PATH="$HOME"/.basher/bin:"$PATH"
    eval "$(basher init - bash)"
fi

# Homebrew <https://brew.sh>.
[ -f /home/linuxbrew/.linuxbrew/bin/brew ] && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
export PATH=/home/linuxbrew/.linuxbrew/bin:"$PATH"

# Debian/Ubuntu
export DEBFULLNAME="Danil Kutkevich"
export DEBEMAIL="danil@kutkevich.org"

# Go <http://golang.org/doc/code.html#GOPATH>.
# Run `go-install-all`.
export GOPATH="$HOME"/go
export PATH="$GOPATH"/bin:"$PATH" #for convenience, add the workspace's bin subdirectory to your PATH
export PATH="/home/linuxbrew/.linuxbrew/opt/go@1.18/bin:$PATH" #go 1.18 from homebrew
# export PATH="$(go env GOPATH)/bin":"$PATH"
# [[ -s "$HOME/.gvm/scripts/gvm" ]] && . "$HOME/.gvm/scripts/gvm" #gvm (Go version manager) <https://github.com/moovweb/gvm>

# Ruby gem homebrew.

# Rubygem executables directory path based on "`brew --prefix ruby`/bin".
if [ -x "$(command -v brew)" ]; then
    export PATH="$(brew --prefix ruby)"/bin:$PATH
fi

# Rubygem executables directory path based on "`gem environment gemdir`/bin".
if [ -x "$(command -v gem)" ]; then
    export PATH="$(gem environment gemdir)"/bin:$PATH
fi

export PATH=/usr/local/lib/ruby/gems/3.0.0/bin:$PATH

# Instead install ruby from homebrew.
# # rbenv ruby version manager <https://github.com/sstephenson/rbenv#basic-github-checkout>.
# export PATH="$HOME"/.rbenv/bin:"$PATH"
# if [ -x "$(command -v rbenv)" ]; then
#     eval "$(rbenv init -)"
# fi

# Travis CI gem.
[ -f "$HOME"/.travis/travis.sh ] && . "$HOME"/.travis/travis.sh #auto completion

# Node.js and npm.
# WARNING: Do NOT give priority to npm executables!!!
export PATH="$HOME"/node_modules/.bin:"$PATH"

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
[ -f "$HOME"/.cargo/env ] && . "$HOME"/.cargo/env # adding `"$HOME"/.cargo/bin` to your PATH to be able to run the installed binaries
export PATH="$HOME"/.cargo/bin:"$PATH"

# Dart <https://dart.dev/get-dart>.
export PATH=/usr/lib/dart/bin:"$PATH"

# # Steel Bank Common Lisp.
# export SBCL_HOME=/usr/lib64/sbcl

# Updates PATH for Yandex Cloud CLI.
if [ -f "$HOME"/yandex-cloud/path.bash.inc ]; then . "$HOME"/yandex-cloud/path.bash.inc; fi
# Enables shell command completion for yc (Yandex Cloud).
if [ -f "$HOME"/yandex-cloud/completion.bash.inc ]; then . "$HOME"/yandex-cloud/completion.bash.inc; fi

# X11
# <https://wiki.archlinux.org/title/Intel_graphics#DRI3_issues>.
# export MESA_LOADER_DRIVER_OVERRIDE=iris
# export LIBGL_DRI3_DISABLE=1

# Qt <https://wiki.archlinux.org/title/HiDPI#Qt_5>.
# export QT_SCALE_FACTOR=1
# export QT_SCREEN_SCALE_FACTORS=1
export QT_AUTO_SCREEN_SCALE_FACTOR=1

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
[[ -f "$HOME"/.bash_prompt.sh ]] && . "$HOME"/.bash_prompt.sh
