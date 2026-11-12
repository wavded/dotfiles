bindkey -e
setopt nocaseglob autocd sharehistory histignorealldups histignorespace
unsetopt correct correctall

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

autoload -Uz compinit
compinit
