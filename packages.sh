#!/usr/bin/env bash
set -x
xcode-select --install

# == Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew update
brew upgrade
brew tap homebrew/cask-versions

# == GNU tools
brew install coreutils
brew install moreutils
brew install gnu-sed
brew install grep
brew install ssh-copy-id

# == Bash
brew install bash
brew install starship
brew install bash-completion@2

# Switch to using brew-installed bash as default shell.
if ! fgrep -q '/opt/homebrew/bin/bash' /etc/shells; then
  echo '/opt/homebrew/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /opt/homebrew/bin/bash;
fi;

# == Utilities
brew install tree
brew install ripgrep
brew install fd
brew install fzf
brew install wget
brew install autojump
brew install tmux
brew install reattach-to-user-namespace
brew install watch
brew install plantuml
brew install redis
brew install neovim
brew install dnscontrol
brew install vale
brew install php-cs-fixer

# == Git
brew install git
brew install git-extras

# == GPG
# https://gist.github.com/bmhatfield/cc21ec0a3a2df963bffa3c1f884b676b#gistcomment-2165971
brew install gnupg
brew install pinentry-mac
mkdir ~/.gnupg
echo "pinentry-program /opt/homebrew/bin/pinentry-mac" > ~/.gnupg/gpg-agent.conf

# == Node
brew install node
brew install pnpm
pnpm install -g \
  eslint \
  prettier \
  @fsouza/prettierd \
  eslint_d \
  nodemon \
  nyc \
  typescript \
  ts-node
pnpm completion

# == Java
brew install java
brew install corretto11
brew install groovy
brew install gradle
brew install google-java-format
brew install kotlin

# == Go
brew install go
mkdir -p ~/Projects/go
brew install golangci-lint
go install golang.org/x/tools/cmd/goimports@latest
go install github.com/segmentio/golines@latest
go install mvdan.cc/gofumpt@latest
go install github.com/golang/mock/mockgen@latest

# == Misc languages
brew install deno
brew install stylua
brew install php
brew install composer
brew tap oven-sh/bun
brew install bun

# == Cask
brew install --cask postico1
brew install --cask docker
brew install --cask the-unarchiver
brew install --cask gitup
brew install --cask imageoptim
brew install --cask hammerspoon
brew install --cask appcleaner
brew install --cask postman
brew install --cask owasp-zap
brew install --cask slack
brew install --cask iterm2
brew install --cask tailscale
brew install --cask 1password

# == Fonts
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font

brew cleanup

# == Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
rustup component add rls
rustup component add rust-analysis
rustup component add rust-src
rustup component add rustfmt
rustup component add clippy
cargo install cargo-update
