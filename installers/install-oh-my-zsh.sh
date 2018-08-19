#!/bin/sh

install_oh_my_zsh() {
  if [ ! -d "$HOME/.oh-my-sh/" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  fi

  if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel9k/" ]; then
    git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
  fi
}

install_oh_my_zsh
