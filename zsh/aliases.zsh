setopt auto_name_dirs
setopt auto_pushd
setopt pushd_ignore_dups

alias ...='cd ../..'
alias -- -='cd -'
alias _='sudo'
alias l='ls -lah'
alias open='gnome-open'
alias ud='packer -Syu --noedit && sudo npm -q update -g'
alias udd='sudo apt-get update && sudo apt-get dist-upgrade'
alias clear='exit'
