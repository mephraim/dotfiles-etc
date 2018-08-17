#!/bin/sh

install_neovim() {
  brew install neovim

  mkdir -p ~/.config/nvim/
  ln -s ~/dotfiles-etc/vim/init.vim ~/.config/nvim/init.vim

  # Add Python support for neovim
  brew install python
  brew install python3
  pip2 install neovim --upgrade
  pip3 install neovim --upgrade
}

# Install neovim if it's not installed yet yet
command -v neovim >/dev/null 2>&1 || install_neovim
