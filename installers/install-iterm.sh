#!/bin/sh

install_iterm() {
  if ! [ $(ls /Applications/ | grep iTerm.app) ]; then
    echo "Installing iTerm2..."
    brew cask install iterm2
    echo "iTerm2 installed!"
  else
    echo "Iterm was already installed."
  fi

  echo "Installing iterm colorscheme"
  open "$DOTFILES_ETC_LOCATION/terminal/Hurtado.itermcolors"
  open "/Applications/iTerm.app"
}

install_iterm
