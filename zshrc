fpath=($HOME/.zsh/functions $HOME/.zsh/completion $fpath)
for config_file ($HOME/.zsh/*.zsh) source $config_file

source $HOME/.zsh/prompt.zsh-theme

autoload -U compinit
compinit -i
