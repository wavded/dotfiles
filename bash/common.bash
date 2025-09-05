# == Aliases

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Use coreutils `ls` if exists.
hash gls >/dev/null 2>&1 || alias gls="ls"

# Use GNU versions if available.
hash ggrep >/dev/null 2>&1 && alias grep="ggrep"
hash ghead >/dev/null 2>&1 && alias head="ghead"
hash gtail >/dev/null 2>&1 && alias tail="gtail"
hash gcp >/dev/null 2>&1 && alias cp="gcp"
hash gsed >/dev/null 2>&1 && alias sed="gsed"

# Enable dircolors.
# hash dircolors >/dev/null 2>&1 || alias dircolors="gdircolors"
# eval `dircolors ~/.bash/dir_colors`

# Always use color, even when piping.
if gls --color > /dev/null 2>&1; then colorflag="--color"; else colorflag="-G"; fi;
export CLICOLOR_FORCE=1

alias ls="gls -AFh ${colorflag} --group-directories-first"
alias la="ls -laF ${colorflag}"

# Use neovim if exists.
hash nvim >/dev/null 2>&1 && alias vim="nvim"
hash nvim >/dev/null 2>&1 && alias vimdiff="nvim -d"

# Pretty tree
alias tree="tree -aC -I '.git|node_modules|vendor' --dirsfirst"

# cat -> bat
hash bat >/dev/null 2>&1 && alias cat="bat"

# ls -> eza
hash eza >/dev/null 2>&1 && alias ls="eza --group-directories-first --icons --hyperlink"

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"

# == Functions

function tm() {
  tmux has-session -t base &> /dev/null

  if [ $? != 0 ]; then
    tmux new-session -s base -d -n base
    tmux attach -t base
  fi

  tmux split-window  -h
  tmux resize-pane   -R 40
  tmux select-pane   -t 0
  sleep 0.2
  tmux send-keys     -t 0 'vim' C-m
}

cleancontainers() { docker rm $(docker ps -q -a); }
cleanimages() { docker rmi $(docker images -q); }

function gockerize() {
  GOOS=linux go build -installsuffix netgo -o app .
  cat > .Dockerfile.scratch << EOF
FROM scratch
COPY . /
CMD ["/app"]
EOF
  docker build -t app -f .Dockerfile.scratch .
  rm .Dockerfile.scratch
  docker run --rm -it -p 3000:3000 app
}

