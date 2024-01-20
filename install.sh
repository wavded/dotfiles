#!/usr/bin/env bash
files=(bash bashrc bash_profile inputrc vale vale.ini gitconfig eslintrc prettierrc vimrc ignore tmux.conf stylua.toml)
dir="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

function rm-if-present { # $1: to-path $2: from-path
  if [ -e $1 ]; then
    rm -rf $1;
  fi
  ln -s $2 $1;
}

for f in "${files[@]}"
do
  rm-if-present "$HOME/.$f" "$dir/$f"
done

# MacOS specific
if [[ `uname` == "Darwin" ]]; then
  rm-if-present "$HOME/.hushlogin" "$dir/hushlogin"
  mkdir -p $HOME/.config
  rm-if-present "$HOME/.config/nvim" "$dir/nvim"
  rm-if-present "$HOME/.config/sharship.toml" "$dir/starship.toml"
  rm-if-present "$HOME/.hammerspoon" "$dir/hammerspoon"

  bash -c ./packages.sh
  bash -c ./fix-terminfo.sh
fi
