#!/usr/bin/env bash
files=(bash bashrc bash_profile inputrc vale vale.ini gitconfig vimrc oxfmtrc.json ignore tmux.conf stylua.toml)
dir="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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

# MacOS specific
if [[ `uname` == "Darwin" ]]; then
  rm-if-present "$HOME/.hushlogin" "$dir/hushlogin"

  mkdir -p $HOME/.config
  mkdir -p "$HOME/.codex"
  mkdir -p "$HOME/.config/herdr"
  mkdir -p "$HOME/Library/Application Support/lazygit"

  rm-if-present "$HOME/.config/herdr/config.toml" "$dir/herdr/config.toml"
  rm-if-present "$HOME/Library/Application Support/lazygit/config.yml" "$dir/lazygit/config.yml"
  rm-if-present "$HOME/.codex/config.toml" "$dir/codex/config.toml"
  rm-if-present "$HOME/.codex/AGENTS.md" "$dir/codex/agents.md"
  rm-if-present "$HOME/.config/nvim" "$dir/nvim"
  rm-if-present "$HOME/.config/sharship.toml" "$dir/starship.toml"

  bash -c ./packages.sh
  bash -c ./fix-terminfo.sh
fi
