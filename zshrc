for file in ~/.zsh/{exports,options,aliases,functions,integrations}.zsh; do
  source "$file"
done
unset file

# >>> md-viewer: report the folder to Rex from zsh (managed by md-viewer setup; edits are replaced) >>>
if [[ -o interactive && -n "${REX_BLOCK-}${REX_SESSION-}" ]]; then
  __md_viewer_osc7() {
    emulate -L zsh
    setopt extendedglob
    local LC_ALL=C
    printf '\e]7;file://%s%s\e\\' "$HOST" "${PWD//(#m)[^A-Za-z0-9\/._~-]/%${(l:2::0:)$(( [##16] #MATCH & 255 ))}}"
  }
  __md_viewer_osc7_chpwd() {
    [[ -t 1 ]] && __md_viewer_osc7
    return 0
  }
  autoload -Uz add-zsh-hook
  add-zsh-hook precmd __md_viewer_osc7
  add-zsh-hook chpwd __md_viewer_osc7_chpwd
fi
# <<< md-viewer zsh <<<
