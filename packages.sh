#!/usr/bin/env bash
xcode-select --install

# === Section: brew ===
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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
brew install bash-completion2

# == Utilities
brew install tree
brew install ripgrep
brew install fd
brew install autojump
brew install tmux
brew install reattach-to-user-namespace
brew install watch
brew install plantuml
brew install neovim

# == Git
brew install git
brew install git-extras

# == GPG
# https://gist.github.com/bmhatfield/cc21ec0a3a2df963bffa3c1f884b676b#gistcomment-2165971
brew install gnupg
brew install pinentry-mac
mkdir ~/.gnupg
echo "pinentry-program /usr/local/bin/pinentry-mac" > ~/.gnupg/gpg-agent.conf

# == Languages
brew install java
brew install deno
brew install node
brew install yarn
brew install yarn-completion
yarn global add \
  eslint \
  prettier \
  nodemon \
  nyc \
  write-good \
  typescript \
  ts-node

brew install go
mkdir -p ~/Projects/go
brew install golangci-lint
go get github.com/nametake/golangci-lint-langserver

# == Cask
brew install --cask postico
brew install --cask docker
brew install --cask the-unarchiver
brew install --cask gitup
brew install --cask imageoptim
brew install --cask hammerspoon
brew install --cask appcleaner
brew install --cask slack
brew install --cask iterm2
brew install --cask viscosity
brew install --cask 1password

# == Fonts
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font

brew cleanup

# Switch to using brew-installed bash as default shell.
if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

# === Rust ===

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
rustup component add rls
rustup component add rust-analysis
rustup component add rust-src
rustup component add rustfmt
rustup component add clippy
cargo install cargo-upgrade
