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

brew install node@6
brew install yarn
brew install go

brew cask install postico
brew cask install docker

yarn global install eslint babel-cli babel-eslint eslint-plugin-react tern istanbul nodemon

brew cleanup
