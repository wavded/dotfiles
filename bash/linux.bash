# Add tab completion for many Bash commands
source /etc/bash_completion

# == Aliases

# System update.
alias update='sudo apt-get update && sudo apt-get dist-upgrade && sudo apt-get autoclean && sudo apt-get autoremove'
