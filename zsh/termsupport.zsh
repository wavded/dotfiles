function set-title {
  print -Pn "\e]2;$2:q\a" # Set window name
  print -Pn "\e]1;$1:q\a" # Set tab name
}

ZSH_TAB_TITLE_IDLE="%15<..<%~%<<" # 15 char left truncated PWD
ZSH_TITLE_IDLE="%n@%m: %~"

# Appears when you have the prompt
function set-title-precmd {
  set-title $ZSH_TAB_TITLE_IDLE $ZSH_TITLE_IDLE
}

# Appears at the beginning of (and during) of command execution
function set-title-preexec {
  emulate -L zsh
  local CMD=${1[(wr)^(*=*|sudo|ssh|-*)]} # cmd name only, or if this is sudo or ssh, the next cmd
  set-title "$CMD" "%100>...>$2%<<"
}

autoload -U add-zsh-hook
add-zsh-hook precmd  set-title-precmd
add-zsh-hook preexec set-title-preexec
