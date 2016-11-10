#!/usr/bin/env bash
for file in ~/.bash/{exports,aliases,functions,options}.bash; do
    [ -r "$file" ] && source "$file"
done
unset file

if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  GIT_PROMPT_THEME_NAME="Custom"
  GIT_PROMPT_THEME_FILE="$HOME/.bash/prompt.bash"
  source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi
