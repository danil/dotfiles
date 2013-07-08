# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

# Correction <http://unix.stackexchange.com/questions/13563/stop-zsh-from-trying-to-correct-command#13564>.
setopt nocorrectall; setopt correct

export PATH=$PATH:/home/danil/.rvm/gems/ruby-1.9.3-p429-railsexpress/bin:/home/danil/.rvm/gems/ruby-1.9.3-p429-railsexpress@global/bin:/home/danil/.rvm/rubies/ruby-1.9.3-p429-railsexpress/bin:/home/danil/.rvm/bin:/home/danil/bin:/home/danil/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/danil/.rvm/bin:/home/danil/.rvm/bin

export EDITOR="nano" #export EDITOR="/usr/bin/emacsclient -t"
export ALTERNATE_EDITOR="/usr/bin/emacs"
export PAGER="/usr/bin/less -IM"
export HISTSIZE=10000
export HISTCONTROL=ignoredups
# See /usr/share/terminfo/*/
# export TERM=rxvt-256color
[ "$TERM" = "xterm" ] && TERM="xterm-256color" #<http://ricochen.wordpress.com/2011/07/23/mac-os-x-lion-terminal-color-remote-access-problem-fix>
#export GIT_PAGER=""

# Aliases.
alias less=$PAGER
alias ec='/usr/bin/emacsclient -t'
# alias ecx='/usr/bin/emacsclient --alternate-editor="" -c "$@"'
# Silver searchers colors configurable <https://github.com/ggreer/the_silver_searcher/issues/90>.
alias ag='ag --smart-case --color-line-number "2;31"'

# # Emacs <http://stackoverflow.com/questions/367442/getting-emacs-ansi-term-and-zsh-to-play-nicely#10050104>.
# if [ -n "$INSIDE_EMACS" ]; then
#   chpwd() { print -P "\033AnSiTc %d" }
#   print -P "\033AnSiTu %n"
#   print -P "\033AnSiTc %d"
# fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" #load RVM (Ruby Version Manager) into a shell session *as a function* <http://rvm.rvm.io/rvm/install>
# [[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion #RVM bash completion <http://rvm.io/workflow/completion>
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Key binding <http://superuser.com/questions/268338/how-i-handle-bindkey-in-zsh#271882>.
bindkey "\el" down-case-word #Oh-my-zsh sets M-l so that it runs the "ls" command. Emacs disagrees, and so my fingers disagree as well <https://github.com/brandon-rhodes/homedir/blob/0cf986776be2335077cf7d86a1f5717084ffc41e/.zshrc#L82>
bindkey "\Xl" delete-char #replace oh-my-zsh C-h "man" binding by backspace
