#!/usr/bin/env bash
files=(bash bashrc bash_profile inputrc gitconfig eslintrc tern-project vimrc ignore tmux.conf)

function rm-if-present { # $1: to-path $2: from-path
  if [ -e $1 ]; then
    rm -rf $1;
  else
    ln -s $2 $1;
  fi
}

for f in "${files[@]}"
do
  rm-if-present "$HOME/.$f" "$PWD/$f"
done

# Neovim for OSX
if [[ `uname` == "Darwin" ]]; then
  rm-if-present "$HOME/.hushlogin" "$PWD/hushlogin"
  mkdir -p $HOME/.config
  rm-if-present "$HOME/.config/nvim" "$PWD/nvim"
fi
