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

function tm() {
  project=`basename $PWD`

  if ! $(tmux has-session -t "$project"); then
    tmux new-session   -s ${project} -d -n workspace
    tmux split-window  -t ${project} -v
    tmux send-keys     -t ${project}:1.0 'vim' C-m
    tmux select-pane   -t ${project}:1.0
    tmux resize-pane   -t ${project} -D 10
  fi

  tmux attach -t "$project"
}
