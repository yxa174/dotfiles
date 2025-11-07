#!/usr/bin/env bash
set -euo pipefail

# Простой установочный скрипт для Vim (конфигурация для программирования, без плагинов)
# Положите этот файл в корень проекта и запустите: chmod +x ./install.sh && ./install.sh

# Записываем базовый .vimrc в домашнюю директорию
cat > "$HOME/.vimrc" <<'EOF'
" Basic Vim config for programming (no plugins)
set nocompatible
filetype plugin indent on
syntax on
set number
set relativenumber
set cursorline
set showcmd
set showmode
set ruler
set encoding=utf-8
set termguicolors
set background=dark

" Tabs and indentation
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set autoindent
set smartindent

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

" Backspace and undo
set backspace=indent,eol,start
set undofile
set undodir=$HOME/.vim/undos

" Split behavior
set splitbelow
set splitright

" Clipboard (use system clipboard if available)
if has('clipboard')
  set clipboard=unnamedplus
endif

" Visual
set wrap
set linebreak
set list
set listchars=tab:▸\ ,trail:·,extends:>,precedes:<

" Better statusline
set laststatus=2
set showtabline=2
EOF

# Создаём необходимые директории
mkdir -p "$HOME/.vim/backups" "$HOME/.vim/swaps" "$HOME/.vim/undos"

echo "install.sh: .vimrc установлен в $HOME/.vimrc и директории созданы."
