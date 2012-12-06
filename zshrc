fpath=($HOME/.zsh/functions $HOME/.zsh/completion $fpath)
for config_file ($HOME/.zsh/*.zsh) source $config_file

autoload -U compinit
compinit -i

# if [ -z "$TMUX" ]; then
#   tmux attach -t default || tmux new -s default
# fi
