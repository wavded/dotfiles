# Run prompt
if [ "$TERM" != "dumb" ]; then
  eval "$(starship init zsh)"
fi

# Enable zoxide.
eval "$(zoxide init zsh --cmd j)"
