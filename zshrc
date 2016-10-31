ulimit -n 2048
autoload -U compinit && compinit
fpath=($HOME/.zsh/completion $fpath)
source $HOME/.zsh/options.zsh
source $HOME/.zsh/variables.zsh
source $HOME/.zsh/termsupport.zsh
source $HOME/.zsh/completion.zsh
source $HOME/.zsh/prompt.zsh

# add npm completion
# if hash npm 2>/dev/null; then
#  . <(npm completion)
# fi

# add golang completion
source $HOME/.zsh/golang.zsh

if [[ `uname` == 'Linux'; ]] then
  source $HOME/.zsh/linux.zsh
fi

if [[ `uname` == 'Darwin'; ]] then
  source $HOME/.zsh/osx.zsh
fi
