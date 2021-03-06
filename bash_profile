#!/usr/bin/env bash
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

export PATH="$HOME/.cargo/bin:$PATH"
