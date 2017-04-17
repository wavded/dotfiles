# == Aliases

# Enable aliases to be sudo’ed
alias sudo='sudo '

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

# Add yarn completion.
source "$HOME/.bash/yarn-completion.bash"

# == Functions

function tm() {
  project=`basename $PWD`

  if ! $(tmux has-session -t "$project"); then
    tmux new-session   -s ${project} -d -n workspace
    tmux split-window  -t ${project} -v
    tmux send-keys     -t ${project}:1.0 'vim' C-m
    tmux resize-pane   -t ${project} -D 10
    tmux select-pane   -t ${project}:1.1
  fi

  tmux attach -t "$project"
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

