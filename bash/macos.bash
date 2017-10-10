if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  GIT_PROMPT_THEME_NAME="Custom"
  GIT_PROMPT_THEME_FILE="$HOME/.bash/prompt.bash"
  source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

# Add tab completion for many Bash commands
source "$(brew --prefix)/share/bash-completion/bash_completion"
source "$(rustc --print sysroot)/etc/bash_completion.d/cargo"

# Enable autojump.
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# == Exports ==
export PATH=/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH

# Disable per-terminal-session history: http://stackoverflow.com/a/34803825
export SHELL_SESSION_HISTORY=0

export GOROOT="$(brew --prefix golang)/libexec"

# Allow OpenSSL to be linked.
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/usr/local/opt/openssl/lib/pkgconfig"

# == Aliases ==

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"

# Empty trash and caches.
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# Flush DNS.
alias flush="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

# Open dev server.
alias opend='open http://localhost:3000'

# System update.
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; yarn global upgrade; rustup update; cargo install-update -a; cargo install --force clippy rustfmt-nightly racer'

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

function connect() {
  osascript -e 'tell application "Tunnelblick"' -e "connect \"$1\"" -e 'end tell'
}

function disconnect() {
  osascript -e 'tell application "Tunnelblick"' -e 'disconnect all' -e 'end tell'
}

function dojsdoc() {
  global_mod="$HOME/.config/yarn/global/node_modules"
  echo "{\"plugins\": [\"${global_mod}/jsdoc-babel\"]}" > __jsdoc.json
  mkdir __jsdocs
  cd __jsdocs
	sleep 1 && open "http://localhost:8000/" &
  python -m SimpleHTTPServer 8000 > /dev/null 2>&1 &
  serve_pid=$!
  cd ..
  watch jsdoc modules index.js -c __jsdoc.json -r -R readme.md -d __jsdocs -t $global_mod/docdash
  kill $serve_pid
  rm __jsdoc.json
  rm -rf __jsdocs
}
