function serve() {
  local port="${1:-8000}";
  sleep 1 && open "http://localhost:${port}/" &
  python3 -m http.server $port
}
