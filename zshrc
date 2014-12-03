fpath=($HOME/.zsh/functions $HOME/.zsh/completion $fpath)
for config_file ($HOME/.zsh/*.zsh) source $config_file

autoload -U compinit
compinit -i

[ -s $HOME/.nvm/nvm.sh ] && . $HOME/.nvm/nvm.sh # This loads NVM
autoload -U compinit && compinit

# add npm completion
if hash npm 2>/dev/null; then
  . <(npm completion)
fi

# load autojump
if hash brew 2>/dev/null; then
  [[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
else
  . /usr/share/autojump/autojump.sh
fi
