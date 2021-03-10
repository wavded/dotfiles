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
brew install fzf
brew install ripgrep
brew install fd
brew install autojump
brew install graphicsmagick
brew install cairo
brew install tmux
brew install reattach-to-user-namespace
brew install watch
brew install cmake
brew install plantuml
brew install python3
brew install neovim
python3 -m pip install --user --upgrade pynvim

# == Git
brew install git
brew install git-extras

# == GPG
# https://gist.github.com/bmhatfield/cc21ec0a3a2df963bffa3c1f884b676b#gistcomment-2165971
brew install gnupg
brew install pinentry-mac
mkdir ~/.gnupg
echo "pinentry-program /usr/local/bin/pinentry-mac" > ~/.gnupg/gpg-agent.conf

brew install node
brew install yarn
brew install go
mkdir -p ~/Projects/go
brew install golangci-lint

# == Cask
brew install --cask postgres
brew install --cask postico
brew install --cask docker
brew install --cask the-unarchiver
brew install --cask java
brew install --cask gitup
brew install --cask imageoptim
brew install --cask hammerspoon

brew cleanup

# Switch to using brew-installed bash as default shell.
if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

# == Deno

curl -fsSL https://deno.land/x/install/install.sh | sh

# === Section: yarn ===

# == Yarn completion
curl -L https://raw.githubusercontent.com/dsifford/yarn-completion/master/yarn-completion.bash > `brew --prefix`/etc/bash_completion.d/yarn

# == Yarn packages
yarn global add \
  eslint \
  eslint-plugin-react \
  eslint-config-prettier \
  eslint-plugin-prettier \
  prettier \
  nodemon \
  nyc \
  write-good \
  typescript \
  ts-node

# === Section: rust ===

# == Rust
curl https://sh.rustup.rs -sSf | sh
reload
rustup component add rls
rustup component add rust-analysis
rustup component add rust-src
rustup component add rustfmt
rustup component add clippy
cargo install cargo-upgrade
