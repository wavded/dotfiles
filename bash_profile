#!/usr/bin/env bash
if [ `uname` == "Darwin" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

for file in ~/.bash/{exports,common,options}.bash; do
    [ -r "$file" ] && source "$file"
done
unset file

if [ `uname` == "Linux" ]; then
  source $HOME/.bash/linux.bash
fi

if [ `uname` == "Darwin" ]; then
  source $HOME/.bash/macos.bash
fi
. "$HOME/.cargo/env"
