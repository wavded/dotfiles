typeset -U PATH path
eval "$(/opt/homebrew/bin/brew shellenv)"

# Make vim the default editor.
export EDITOR='vim';
hash nvim >/dev/null 2>&1 && export EDITOR="nvim"

export PATH=/usr/local/bin:/usr/libexec:$PATH

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';

# Highlight inside manpages and elsewhere.
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X';

# ==== Vault ====
export VAULT_ADDR=https://vault.adc.int:8200
export VAULT_CACERT="$HOME/.vault-certs/server.crt"

# ==== Java ====
export JAVA_HOME="/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home"

# ==== Go ====
export GOPATH=$HOME/Projects/go
export PATH="$GOPATH/bin:$PATH"

# ==== Rust ====
export PATH="$HOME/.cargo/bin:$PATH"

export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="$HOME/dotfiles/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.bun/bin:$PATH"

# Disable per-terminal-session history: http://stackoverflow.com/a/34803825
export SHELL_SESSION_HISTORY=0
