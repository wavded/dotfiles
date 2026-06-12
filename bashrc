# Only source configuration when in an interactive session.
# https://shreevatsa.wordpress.com/2008/03/30/zshbash-startup-files-loading-order-bashrc-zshrc-etc/
[ -n "$PS1" ] && source ~/.bash_profile
. "$HOME/.cargo/env"
