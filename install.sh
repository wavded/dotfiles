#!/bin/bash
files=( zsh zshrc gitconfig hushlogin eslintrc tern-project )

for f in "${files[@]}"
do
  ln -fs "$PWD/$f" "$HOME/.$f";
done

# Neovim
mkdir -p $HOME/.config
ln -fs "$PWD/vim" "$HOME/.config/nvim";

vim -S vim/snapshot.vim
