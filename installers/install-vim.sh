#!/bin/sh

# Link the vim folder
ln -s ~/dotfiles-etc/vim ~/.vim

# Link the vimrc file for older versions of vim that won't look in .vim
ln -s ~/dotfiles-etc/vim/vimrc ~/.vimrc

# Install all of the vim plugins
vim +PlugInstall +qall
