# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

# Bash it <https://github.com/revans/bash-it>.
export BASH_IT=$HOME/.bash_it #Path to the bash it configuration
source $BASH_IT/bash_it.sh #load bash It

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
alias e='emacs -nw'
# alias ec='~/.evm/installations/emacs-24.3/bin/emacsclient -t'
alias ec='/usr/bin/emacsclient -t'
# alias ecx='/usr/bin/emacsclient --alternate-editor="" -c "$@"'
alias g='git'
# Silver searchers colors configurable <https://github.com/ggreer/the_silver_searcher/issues/90>.
alias my-ag='ag --smart-case --color-line-number "2;31"'
alias dm='my_dmenu_run.sh'
alias em='emerge --verbose --oneshot --color=y'
alias cd-w='cd ~/src/vendor/waveaccess'
alias cd-wm='cd ~/src/vendor/waveaccess/medapp'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion #RVM bash completion <http://rvm.io/workflow/completion>
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Steel Bank Common Lisp.
export SBCL_HOME=/usr/lib64/sbcl

# Node.js
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh # This loads NVM

# # Lua.
# PATH=~/.luarocks/bin:"${PATH}"
# export LUA_PATH="/home/danil/.luarocks/share/lua/5.1//?.lua;./?.lua;$LUA_PATH"
# export LUA_CPATH="/home/danil/.luarocks/lib/lua/5.1//?.so;./?.so;$LUA_CPATH"

# # Emacs Cask <http://cask.github.io>.
# PATH=$PATH:$HOME/.cask/bin

# # EVM (Emacs Version Manager) <https://github.com/rejeep/evm>.
# PATH=$PATH:$HOME/.evm/bin

# Prompt.
[[ -f ~/.bash_prompt.sh ]] && source ~/.bash_prompt.sh
