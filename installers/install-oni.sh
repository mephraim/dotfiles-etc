#!/bin/sh

install_oni() {
  if command -v oni >/dev/null 2>&1; then
    echo "Oni is already installed"
  else
    brew update
    brew cask install oni

    mkdir -p "$HOME/.config/oni/"
    ln -s "$DOTFILES_ETC_LOCATION/oni" "$HOME/.config/oni"

    defaults write com.extropy.oni ApplePressAndHoldEnabled -bool false
  fi
}

install_oni
