# Enable aliases to be sudo’ed
alias sudo='sudo '

# ==== LS ====

# Use coreutils `ls` if exists.
hash gls >/dev/null 2>&1 || alias gls="ls"

# Enable dircolors.
hash dircolors >/dev/null 2>&1 || alias dircolors="gdircolors"
eval `dircolors ~/.bash/dir_colors`

# Always use color, even when piping.
if gls --color > /dev/null 2>&1; then colorflag="--color"; else colorflag="-G"; fi;
export CLICOLOR_FORCE=1

alias ls="gls -AFh ${colorflag} --group-directories-first"
alias la="ls -laF ${colorflag}"

# Use neovim if exists.
hash nvim >/dev/null 2>&1 && alias vim="nvim"

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Pretty tree
alias tree="tree -aC -I '.git|node_modules|bower_components' --dirsfirst"

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"

# ==== MacOS ====

# Empty trash and caches.
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# Flush DNS.
alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"

# Open dev server.
alias opend='open http://localhost:3000'

# System update.
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm update -g'

# Lock screen.
alias lock="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
