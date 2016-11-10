# Make vim the default editor.
export EDITOR='vim';
hash nvim >/dev/null 2>&1 && export EDITOR="nvim"

# Increase Bash history size. Allow 32³ entries; the default is 500.
export HISTSIZE='32768';
export HISTFILESIZE="${HISTSIZE}";
# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='ignoreboth';
# Save and reload the history after each command finishes.
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

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

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;31'

# ==== Go ====
export GOPATH=$HOME/Projects/go
export GOBIN=$HOME/Projects/go/bin
export PATH=/usr/local/go/bin:$GOBIN:$PATH