[[ $- == *i* ]] || return

export EDITOR=vim
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

HISTSIZE=10000
HISTCONTROL=ignoreboth
shopt -s histappend checkwinsize
set -o emacs

alias ls='ls --color=auto --group-directories-first -AFh'

PS1='\u@\h:\w\$ '
