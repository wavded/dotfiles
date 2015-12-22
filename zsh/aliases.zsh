setopt auto_name_dirs
setopt auto_pushd
setopt pushd_ignore_dups

alias ...='cd ../..'
alias -- -='cd -'
alias _='sudo'
alias l='ls -lah'
alias ud='brew update && brew upgrade && npm update -g'
alias udd='sudo apt-get update && sudo apt-get dist-upgrade'
alias s='serve -p 8000 & (sleep 0.5 && open http://localhost:8000); fg'
alias vim='nvim'
