#!/bin/bash
files=(zsh zshrc gitconfig eslintrc tern-project vimrc ignore)

function ln-if-absent { # $1: to-path $2: from-path
  if [ -e $1 ]; then
    echo "$1 exists"
  else
    ln -s $2 $1;
  fi
}

for f in "${files[@]}"
do
  ln-if-absent "$HOME/.$f" "$PWD/$f"
done

# Neovim for OSX
if [[ `uname` == "Darwin" ]]; then
  ln-if-absent "$HOME/.hushlogin" "$PWD/hushlogin"
  mkdir -p $HOME/.config
  ln-if-absent "$HOME/.config/nvim" "$PWD/nvim"
fi
