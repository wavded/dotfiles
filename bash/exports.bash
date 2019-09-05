# Make vim the default editor.
export EDITOR='vim';
hash nvim >/dev/null 2>&1 && export EDITOR="nvim"

# Increase Bash history size slightly; the default is 500.
export HISTSIZE=10000;
# Omit duplicates from history.
export HISTCONTROL="erasedups"
# Ignore certain commands.
export HISTIGNORE=$'&:[ \t]*:[fb]g:l[slad]*:cd*:mv*:clear:exit:\:*'

# Save and reload the history after each command finishes to make it available for other sessions (may cause dups).
# export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

export PATH=/usr/local/bin:$PATH

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

export TERM=xterm-256color
export DEFAULT_USER=wavded
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/opt/X11/lib/pkgconfig

# ==== Go ====
export GOPATH=$HOME/Projects/go
export GOBIN=$HOME/Projects/go/bin
export PATH=${GOPATH}/bin:$GOBIN:$PATH

# ==== Haskell ====
export PATH=$HOME/Library/Haskell/bin:$PATH

# ==== Yarn ====
hash yarn >/dev/null 2>&1 && export PATH=$PATH:$HOME/.config/yarn/global/node_modules/.bin

# ==== Rust ====
export PATH="$HOME/.cargo/bin:$PATH"
hash rustc >/dev/null 2>&1 && export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
