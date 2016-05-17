files=( zsh zshrc vim vimrc gitconfig hushlogin eslintrc tern-project )

for f in "${files[@]}"
do
  ln -fs "$PWD/$f" "$HOME/.$f";
done
