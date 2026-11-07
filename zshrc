for file in ~/.zsh/{exports,options,aliases,functions,integrations}.zsh; do
  source "$file"
done
unset file
