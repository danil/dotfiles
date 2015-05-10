# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

# # Bash it <https://github.com/revans/bash-it>.
# export BASH_IT=$HOME/.bash_it #Path to the bash it configuration
# source $BASH_IT/bash_it.sh #load bash It

# Set PATH so it includes user's private bin if it exists.
PATH=~/bin:"${PATH}"
PATH=~/local/bin:"${PATH}"

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
# alias e='~/.evm/installations/emacs-24.3/bin/emacs -nw'
alias e='emacs --no-window-system'
# alias ec='~/.evm/installations/emacs-24.3/bin/emacsclient -t'
alias ec='emacsclient --tty'
# alias ecx='emacsclient --alternate-editor="" -c "$@"'
# Silver searchers colors configurable <https://github.com/ggreer/the_silver_searcher/issues/90>.
alias my-ag='ag --smart-case --color-line-number "2;31"'

# rbenv <https://github.com/sstephenson/rbenv#basic-github-checkout>.
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# # RVM (ruby version manager).
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
# [[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion #RVM bash completion <http://rvm.io/workflow/completion>
# export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[ -f "$HOME/.travis/travis.sh" ] && source "$HOME/.travis/travis.sh" #added by travis gem

# Steel Bank Common Lisp.
export SBCL_HOME=/usr/lib64/sbcl

# Node.js
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  #this loads nvm
[[ -r "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"
PATH="$HOME/node_modules/.bin:$PATH"

# # Lua.
# PATH=~/.luarocks/bin:"${PATH}"
# export LUA_PATH="/home/danil/.luarocks/share/lua/5.1//?.lua;./?.lua;$LUA_PATH"
# export LUA_CPATH="/home/danil/.luarocks/lib/lua/5.1//?.so;./?.so;$LUA_CPATH"

# Go <http://golang.org/doc/code.html#GOPATH>.
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin #for convenience, add the workspace's bin subdirectory to your PATH

# # Emacs Cask <http://cask.github.io>.
# export PATH="$HOME/.cask/bin:$PATH"

# # EVM (Emacs Version Manager) <https://github.com/rejeep/evm>.
# PATH=$PATH:$HOME/.evm/bin

# pip (python package management system).
export PATH=$PATH:$HOME/.local/bin

# Prompt.
[[ -f ~/.bash_prompt.sh ]] && source ~/.bash_prompt.sh
