#!/usr/bin/env zsh
files=(inputrc vale vale.ini gitconfig vimrc ignore stylua.toml)
dir="${0:A:h}"

function rm-if-present { # $1: to-path $2: from-path
  if [ -e "$1" ] || [ -L "$1" ]; then
    rm -rf "$1";
  fi
  ln -s "$2" "$1";
}

for f in "${files[@]}"
do
  rm-if-present "$HOME/.$f" "$dir/$f"
done

if [[ $(uname) == "Linux" ]]; then
  rm-if-present "$HOME/.bashrc" "$dir/bashrc"
fi

# MacOS specific
if [[ `uname` == "Darwin" ]]; then
  rm-if-present "$HOME/.zshrc" "$dir/zshrc"
  rm-if-present "$HOME/.zsh" "$dir/zsh"
  rm-if-present "$HOME/.hushlogin" "$dir/hushlogin"

  mkdir -p "$HOME/.codex"
  mkdir -p "$HOME/.config/rex"

  rm-if-present "$HOME/.config/rex/init.lua" "$dir/rex/init.lua"
  rm-if-present "$HOME/.codex/config.toml" "$dir/codex/config.toml"
  rm-if-present "$HOME/.codex/agents.md" "$dir/codex/agents.md"
  rm-if-present "$HOME/.config/nvim" "$dir/nvim"
  rm-if-present "$HOME/.config/starship.toml" "$dir/starship.toml"

  zsh "$dir/packages.sh"
fi
