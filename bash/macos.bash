if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  GIT_PROMPT_THEME_NAME="Custom"
  GIT_PROMPT_THEME_FILE="$HOME/.bash/prompt.bash"
  source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

# Add tab completion for many Bash commands
export BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d"
source "$(brew --prefix)/share/bash-completion/bash_completion"
source "$(rustc --print sysroot)/etc/bash_completion.d/cargo"
[ -f ~/.config/tabtab/bash/__tabtab.bash ] && . ~/.config/tabtab/bash/__tabtab.bash || true

# Enable autojump.
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# == Exports ==
export PATH=/opt/homebrew/opt/node@16/bin:$PATH
export PATH=/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.deno/bin:$PATH"
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

# Empty trash and caches.
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# Recursively delete `.DS_Store` files
alias cleanup="fd -x rm \; -t f -HI .DS_Store"

# Flush DNS.
alias flush="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

# System update.
alias update='$HOME/dotfiles/update-packages.sh'

# Lock screen.
alias lock="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# Chrome.
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

# == Functions ==

function serve() {
	local port="${1:-8000}";
	sleep 1 && open "http://localhost:${port}/" &
	# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
	# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
	python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port";
}

function vpn() {
  osascript -e 'tell application "Viscosity" to connect "utils"'
}

function vpnoff() {
  osascript -e 'tell application "Viscosity" to disconnectall'
}
