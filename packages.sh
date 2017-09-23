#!/usr/bin/env bash

# === Section: brew ===

brew update
brew upgrade

# == GNU Tools
brew install coreutils
brew install moreutils
brew install gnu-sed --with-default-names
brew install grep
brew install ssh-copy-id

# == Bash
brew install neovim/neovim/neovim
brew install bash
brew install bash-git-prompt
brew install bash-completion2

# == Utilities
brew install tree
brew install ripgrep
brew install autojump
brew install graphicsmagick
brew install cairo
brew install tmux
brew install reattach-to-user-namespace
brew install watch

# == Git
brew install git
brew install git-extras

brew install node
brew install yarn
brew install go

# == Cask
brew cask install postgres
brew cask install postico
brew cask install docker
brew cask install the-unarchiver
brew cask install java
brew cask install gitup
brew cask install imageoptim

brew cleanup

# Switch to using brew-installed bash as default shell.
if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

# === Section: yarn ===

# == Yarn completion
curl -L https://raw.githubusercontent.com/dsifford/yarn-completion/master/yarn-completion.bash > `brew --prefix`/etc/bash_completion.d/yarn

# == Yarn packages
yarn global add \
  babel-core \
  babel-cli \
  eslint \
  babel-eslint \
  eslint-plugin-react \
  eslint-config-adc \
  jsdoc \
  jsdoc-babel \
  docdash \
  tern \
  istanbul \
  concurrently \
  stylefmt \
  tidy-markdown@2.0.4 \
  nodemon

# === Section: rust ===

# == Rust
curl https://sh.rustup.rs -sSf | sh
rustup install nightly
rustup default nightly

# == Cargo packages
cargo install clippy
cargo install racer
cargo install rustfmt
cargo install cargo-update
