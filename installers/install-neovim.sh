#!/bin/sh

install_neovim() {
  if command -v nvim >/dev/null 2>&1; then
    echo "Neovim is already intalled"
  else
    brew update
    brew install neovim

    # Add Python support for neovim
    brew install python
    brew install python3
    brew postinstall python3
    pip3 install --user pynvim

    pip2 install neovim --upgrade
    pip3 install neovim --upgrade
  fi

  if [ ! -d "$HOME/.config/nvim/" ]; then
    mkdir -p "$HOME/.config/nvim/"
  fi

  if [ ! -e "$HOME/.config/nvim/init.vim" ]; then
    ln -s "$DOTFILES_ETC_LOCATION/vim/init.vim" "$HOME/.config/nvim/init.vim"
  fi
}

install_neovim
