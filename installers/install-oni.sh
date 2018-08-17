#!/bin/sh

install_oni() {
  brew update
  brew cask install oni

  mkdir -p ~/.config/oni/
  ln -s ~/dotfiles-etc/oni ~/.config/oni

  defaults write com.extropy.oni ApplePressAndHoldEnabled -bool false
}

# Install oni if it's not installed yet
command -v oni >/dev/null 2>&1 || install_oni
