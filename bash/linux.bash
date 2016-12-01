# Add tab completion for many Bash commands
source /etc/bash_completion

# == Aliases

# System update.
alias update='sudo apt-get update && sudo apt-get dist-upgrade && sudo apt-get autoclean && sudo apt-get autoremove'

# Update dotfiles.
bgtask "cd $HOME/dotfiles; git clean -dfx; git checkout .; git pull origin/master; ./install.sh"
