# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

# Set PATH so it includes user's private bin if it exists.
PATH=~/bin:"${PATH}"
PATH=~/local/bin:"${PATH}"

# Tab completion
# <http://en.gentoo-wiki.com/wiki/TAB-Completion#Installation>.
[[ -f /etc/profile.d/bash-completion.sh ]] && source /etc/profile.d/bash-completion.sh

# Disable the XOFF (Ctrl-s) keystroke
# <http://superuser.com/questions/124845/can-you-disable-the-ctrl-s-xoff-keystroke-in-putty#155875>.
stty -ixon

export EDITOR="vim" #export EDITOR="nano" #export EDITOR="/usr/bin/emacsclient -t"
# export ALTERNATE_EDITOR="/usr/bin/emacs"
export PAGER="/usr/bin/less -IM"
export HISTSIZE=10000
export HISTCONTROL=ignoredups
# See /usr/share/terminfo/*/
# export TERM=rxvt-256color
[ "$TERM" = "xterm" ] && TERM="xterm-256color" #<http://ricochen.wordpress.com/2011/07/23/mac-os-x-lion-terminal-color-remote-access-problem-fix>
#export GIT_PAGER=""

# Aliases.
alias less=$PAGER
alias e='~/.evm/installations/emacs-24.3/bin/emacs -nw'
# alias ec='/usr/bin/emacsclient -t'
alias ec='~/.evm/installations/emacs-24.3/bin/emacsclient -t'
# alias ecx='/usr/bin/emacsclient --alternate-editor="" -c "$@"'
# Silver searchers colors configurable <https://github.com/ggreer/the_silver_searcher/issues/90>.
alias ag='ag --smart-case --color-line-number "2;31"'

# Prompt.
[[ -f ~/.bash_prompt.sh ]] && source ~/.bash_prompt.sh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" #load RVM (Ruby Version Manager) into a shell session *as a function* <http://rvm.rvm.io/rvm/install>
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion #RVM bash completion <http://rvm.io/workflow/completion>
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Emacs Cask <http://cask.github.io>.
PATH=$PATH:$HOME/.cask/bin

# EVM (Emacs Version Manager) <https://github.com/rejeep/evm>.
PATH=$PATH:$HOME/.evm/bin

# Lua.
PATH=~/.luarocks/bin:"${PATH}"
export LUA_PATH="/home/danil/.luarocks/share/lua/5.1//?.lua;./?.lua;$LUA_PATH"
export LUA_CPATH="/home/danil/.luarocks/lib/lua/5.1//?.so;./?.so;$LUA_CPATH"
#export LUA_INIT="require 'luarocks.require'"

# Node.js
export NODE_PATH="$HOME/local:$HOME/local/lib/node_modules"
PATH=~/node_modules/.bin:"${PATH}"
