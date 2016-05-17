#!/bin/bash -x
files=(zsh zshrc gitconfig hushlogin eslintrc tern-project esformatter)

for f in "${files[@]}"
do
  if [ -e $HOME/.$file ]; then
    echo ".$f exists"
  else
    ln -s $PWD/$f $HOME/.$f;
  fi
done

# Neovim
mkdir -p $HOME/.config
if [ -e $HOME/.config/nvim ]; then
  echo ".config/nvim exists"
else
  ln -s $PWD/vim $HOME/.config/nvim;
fi
