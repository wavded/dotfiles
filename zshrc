fpath=($HOME/.zsh/functions $HOME/.zsh/completion $fpath)
for config_file ($HOME/.zsh/*.zsh) source $config_file

autoload -U compinit
compinit -i

# add npm completion
if (( $+commands[npm] )) ; then
  . <(npm completion)
fi
