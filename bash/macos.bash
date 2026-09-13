# Add tab completion for many Bash commands
export BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d"
source "$(brew --prefix)/share/bash-completion/bash_completion"
source "$(rustc --print sysroot)/etc/bash_completion.d/cargo"

# == Exports ==
export PATH="/opt/homebrew/opt/node@24/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/dotfiles/bin:$PATH"
. "$HOME/.cargo/env"

# Disable per-terminal-session history: http://stackoverflow.com/a/34803825
export SHELL_SESSION_HISTORY=0

export GOROOT="$(brew --prefix golang)/libexec"
export JDTLS_HOME=$HOME/.local/share/nvim/lsp_servers/jdtls

# Allow OpenSSL to be linked.
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/usr/local/opt/openssl/lib/pkgconfig"

# == Aliases ==

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
alias lg="lazygit"

# Agents
alias cm='codex --model gpt-5.6-luna -c model_reasoning_effort=high'
alias ct='codex --model gpt-5.6-sol -c model_reasoning_effort=high'
alias cr='codex resume --last'

# Empty trash and caches.
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# Recursively delete `.DS_Store` files
alias cleanup="fd -x rm \; -t f -HI .DS_Store"

# Flush DNS.
alias flush="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

# Lock screen.
alias lock="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# == Functions ==

function serve() {
  local port="${1:-8000}";
  sleep 1 && open "http://localhost:${port}/" &
  python3 -m http.server $port
}

# Run prompt
if [ "$TERM" != "dumb" ]; then
  eval "$(starship init bash)"
fi

# Enable zoxide.
eval "$(zoxide init bash --cmd j)"
