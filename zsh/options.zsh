bindkey -e
setopt nocaseglob autocd correct sharehistory histignorealldups histignorespace

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

autoload -Uz compinit
compinit
