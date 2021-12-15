#!/usr/bin/env bash
xcode-select --install

# === Section: brew ===
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew update
brew upgrade

# == GNU Tools
brew install coreutils
brew install moreutils
brew install gnu-sed
brew install grep
brew install ssh-copy-id

# == Bash
brew install bash
brew install bash-git-prompt
brew install bash-completion@2

# == Utilities
brew install tree
brew install ripgrep
brew install fd
brew install autojump
brew install tmux
brew install reattach-to-user-namespace
brew install watch
brew install plantuml
brew install redis
brew install neovim
brew install dnscontrol

# == Git
brew install git
brew install git-extras

# == GPG
# https://gist.github.com/bmhatfield/cc21ec0a3a2df963bffa3c1f884b676b#gistcomment-2165971
brew install gnupg
brew install pinentry-mac
mkdir ~/.gnupg
echo "pinentry-program /opt/homebrew/bin/pinentry-mac" > ~/.gnupg/gpg-agent.conf

# == Languages
brew install java
brew install deno
brew install stylua
brew install node
brew install php
brew install yarn
brew install yarn-completion
yarn global add \
  eslint \
  prettier \
  @fsouza/prettierd \
  nodemon \
  nyc \
  write-good \
  typescript \
  ts-node

# === Go ===
brew install go
mkdir -p ~/Projects/go
brew install golangci-lint
go install github.com/nametake/golangci-lint-langserver@latest
go install golang.org/x/tools/cmd/goimports@latest
go install mvdan.cc/gofumpt@latest
go install github.com/golang/mock/mockgen@latest

# == Cask
brew install --cask postico
brew install --cask docker
brew install --cask the-unarchiver
brew install --cask gitup
brew install --cask imageoptim
brew install --cask hammerspoon
brew install --cask appcleaner
brew install --cask postman
brew install --cask skitch
brew install --cask owasp-zap
brew install --cask slack
brew install --cask iterm2
brew install --cask viscosity
brew install --cask 1password

# == Fonts
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font

brew cleanup

# Switch to using brew-installed bash as default shell.
if ! fgrep -q '/opt/homebrew/bin/bash' /etc/shells; then
  echo '/opt/homebrew/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /opt/homebrew/bin/bash;
fi;

# === Rust ===

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
rustup component add rls
rustup component add rust-analysis
rustup component add rust-src
rustup component add rustfmt
rustup component add clippy
cargo install cargo-update
