#!/bin/bash

# Создаем симлинк для .vimrc
ln -sf ~/dotfiles/.vimrc ~/.vimrc

# Устанавливаем vim-plug и плагины
~/dotfiles/vim-plug-install.sh

# Создаем необходимые директории
mkdir -p ~/.vim/backups
mkdir -p ~/.vim/swaps
mkdir -p ~/.vim/undos
