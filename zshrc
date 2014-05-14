fpath=($HOME/.zsh/functions $HOME/.zsh/completion $fpath)
for config_file ($HOME/.zsh/*.zsh) source $config_file

autoload -U compinit
compinit -i

[ -s $HOME/.nvm/nvm.sh ] && . $HOME/.nvm/nvm.sh # This loads NVM
autoload -U compinit && compinit

# add npm completion
if ! type "$npm" > /dev/null; then
  . <(npm completion)
fi

# load autojump
if ! type "$autojump" > /dev/null; then
  [[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
fi

