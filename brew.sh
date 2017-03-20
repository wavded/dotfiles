#!/usr/bin/env bash
brew update
brew upgrade

# Replace Mac tools with GNU ones.
brew install coreutils
brew install moreutils
brew install searchutils

# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names
brew install ssh-copy-id

brew install neovim/neovim/neovim
brew install bash
brew install bash-git-prompt
brew install tree
brew install ripgrep
brew install autojump
brew install graphicsmagick
brew install cairo
brew install tmux
brew install reattach-to-user-namespace
brew install watch

brew install git
brew install git-extras

brew install node
brew install yarn
brew install go

brew cask install postgres
brew cask install postico
brew cask install docker
brew cask install the-unarchiver
brew cask install java
brew cask install gitup
brew cask install imageoptim

yarn global install eslint babel-cli babel-eslint eslint-plugin-react tern istanbul nodemon

brew cleanup
