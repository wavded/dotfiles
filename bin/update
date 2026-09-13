#!/usr/bin/env bash
set -x

# == MacOS
sudo softwareupdate -i -a

# == Homebrew
brew update
brew upgrade
brew cleanup

# == Node
pnpm up -gL
bun up -gL

# == Go
go install golang.org/x/tools/cmd/goimports@latest
go install mvdan.cc/gofumpt@latest
go install golang.org/x/vuln/cmd/govulncheck@latest

# -- GitHub
gh extension upgrade --all

# == Rust
rustup update
cargo install-update -a
