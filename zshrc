fpath=($HOME/.zsh/functions $HOME/.zsh/completion $fpath)
for config_file ($HOME/.zsh/*.zsh) source $config_file

autoload -U compinit
compinit -i

autoload -U compinit && compinit

# add npm completion
if hash npm 2>/dev/null; then
  . <(npm completion)
fi

# load autojump
if hash brew 2>/dev/null; then
  [[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
fi

export FZF_DEFAULT_COMMAND='ag -l -g ""'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="/home/wavded/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
