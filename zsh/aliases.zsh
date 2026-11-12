# Enable aliases to be sudo’ed
alias sudo='sudo '

# Use GNU versions if available.
hash ggrep >/dev/null 2>&1 && alias grep="ggrep"
hash ghead >/dev/null 2>&1 && alias head="ghead"
hash gtail >/dev/null 2>&1 && alias tail="gtail"
hash gcp >/dev/null 2>&1 && alias cp="gcp"
hash gsed >/dev/null 2>&1 && alias sed="gsed"

# ls -> eza
hash eza >/dev/null 2>&1 && alias ls="eza --group-directories-first --icons --hyperlink --git"
alias la="ls -laF"

# Use neovim if exists.
hash nvim >/dev/null 2>&1 && alias vim="nvim"
hash nvim >/dev/null 2>&1 && alias vimdiff="nvim -d"

# Pretty tree
alias tree="tree -aC -I '.git|node_modules|vendor' --dirsfirst"

# cat -> bat
hash bat >/dev/null 2>&1 && alias cat="bat"

# Reload the shell (i.e. invoke as a login shell)
alias reload='exec zsh -l'

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

# Codex
alias c='codex --profile trusted --model gpt-6.1-sol'
alias cm='codex --profile trusted --model gpt-6.1-terra -c model_reasoning_effort=medium -c service_tier=fast'
alias ct='codex --profile trusted --model gpt-6.1-sol -c model_reasoning_effort=high'
alias cr='codex --profile trusted resume --last'

# Recursively delete `.DS_Store` files
alias cleanup="fd -HI -t f -g .DS_Store -x rm"

# Flush DNS.
alias flush="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
