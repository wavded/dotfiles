#!/usr/bin/env bash
set -x

# == MacOS
sudo softwareupdate -i -a

# == Homebrew
brew update
brew upgrade
brew upgrade --cask
brew cleanup

# == Node
pnpm up -gL

# == Go
go install golang.org/x/tools/cmd/goimports@latest
go install github.com/segmentio/golines@latest
go install mvdan.cc/gofumpt@latest
go install golang.org/x/vuln/cmd/govulncheck@latest
go install github.com/golang/mock/mockgen@latest

# == Rust
rustup update
cargo install-update -a
