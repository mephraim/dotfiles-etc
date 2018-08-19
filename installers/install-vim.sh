#!/bin/sh

# Link the vim folder
ln -s "$DOTFILES_ETC_LOCATION/vim" ~/.vim

# Link the vimrc file for older versions of vim that won't look in .vim
ln -s "$DOTFILES_ETC_LOCATION/vim/vimrc" ~/.vimrc

# Install all of the vim plugins
vim +PlugInstall +qall
