# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

# Set PATH so it includes user's private bin if it exists.
PATH="$HOME"/bin:"$PATH"
PATH="$HOME"/local/bin:"$PATH"

# Tab completion
# <http://wiki.gentoo.org/wiki/Bash#Tab_completion>.
[[ -f /etc/profile.d/bash-completion.sh ]] && source /etc/profile.d/bash-completion.sh

# Disable the XOFF (Ctrl-s) keystroke
# <http://superuser.com/questions/124845/can-you-disable-the-ctrl-s-xoff-keystroke-in-putty#155875>.
stty -ixon

export EDITOR="vim" #export EDITOR="nano" #export EDITOR="/usr/bin/emacsclient -t"
# export ALTERNATE_EDITOR="/usr/bin/emacs"
export GIT_EDITOR='vim'
export PAGER="/usr/bin/less -IM"
export HISTSIZE=10000
export HISTFILESIZE=10000
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
alias less=$PAGER
alias e='emacs --no-window-system'
alias ec='emacsclient --tty'

# rbenv <https://github.com/sstephenson/rbenv#basic-github-checkout>.
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

[ -f "$HOME/.travis/travis.sh" ] && source "$HOME/.travis/travis.sh" #added by travis gem

export PATH="$PATH":"$HOME"/deps/bin #bpkg bash package manager <https://github.com/bpkg/bpkg#installing-packages>

# Steel Bank Common Lisp.
export SBCL_HOME=/usr/lib64/sbcl

# Node.js
export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  #this loads nvm
[[ -r "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"
export PATH="$HOME/node_modules/.bin:$PATH"

# # lenv (Lua version manager) <https://github.com/mah0x211/lenv>.
# export PATH="$HOME"/.lenv/bin:"$HOME"/.lenv/current/bin:$PATH
# export LUA_PATH="$HOME"'/.lenv/current/luarocks/share/?.lua;'"$HOME"'/.lenv/current/luarocks/share/?/init.lua;;'
# export LUA_CPATH="$HOME"'/.lenv/current/luarocks/lib/?.so;;'

# # Lua.
# PATH="$HOME"/.luarocks/bin:"$PATH"
# export LUA_PATH="$HOME""/.luarocks/share/lua/5.1//?.lua;./?.lua;$LUA_PATH"
# export LUA_CPATH="$HOME""/.luarocks/lib/lua/5.1//?.so;./?.so;$LUA_CPATH"

# Go <http://golang.org/doc/code.html#GOPATH>.
export GOPATH="$HOME"/go
export PATH="$PATH":"$GOPATH"/bin #for convenience, add the workspace's bin subdirectory to your PATH

# gvm (Go version manager) <https://github.com/moovweb/gvm>.
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# rsvm (Rust version manager) <https://github.com/sdepold/rsvm>.
[[ -s "$HOME"/.rsvm/rsvm.sh ]] && . "$HOME"/.rsvm/rsvm.sh #this loads rsvm

# Emacs Cask <http://cask.github.io>.
export PATH="$HOME/.cask/bin:$PATH"

# pip (python package management system).
export PATH="$PATH":"$HOME"/.local/bin

# Travis gem tab auto completion.
[ -f "$HOME"/.travis/travis.sh ] && source "$HOME"/.travis/travis.sh

# Prompt.
[[ -f "$HOME"/.bash_prompt.sh ]] && source "$HOME"/.bash_prompt.sh
