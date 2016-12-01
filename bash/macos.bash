if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  GIT_PROMPT_THEME_NAME="Custom"
  GIT_PROMPT_THEME_FILE="$HOME/.bash/prompt.bash"
  source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

# Add tab completion for many Bash commands
source "$(brew --prefix)/share/bash-completion/bash_completion"

# Enable autojump.
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# == Exports ==
export PATH=/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH

# == Aliases ==

# Empty trash and caches.
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# Flush DNS.
alias flush="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

# Open dev server.
alias opend='open http://localhost:3000'

# System update.
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm update -g'

# Lock screen.
alias lock="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"


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

