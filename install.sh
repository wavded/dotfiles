for file in *; do
  if [ '$file' != 'Makefile' ] && [ '$file' != 'readme.md' ]; then
    if [ -e "$HOME/.$file" ]; then
      echo "$HOME/.$file exists";
    else
      ln -s "$PWD/$file" "$HOME/.$file";
    fi
  fi
done
