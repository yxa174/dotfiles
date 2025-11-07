#!/bin/bash

# Установка vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Установка плагинов через vim-plug
vim -E -s -c "source ~/.vimrc" -c "PlugInstall" -c "qa"
