set number
syntax on
set tabstop=4
set expandtab
" Настройки менеджера плагинов vim-plug
call plug#begin('~/.vim/plugged')

" Список плагинов
Plug 'preservim/nerdtree'          " Файловый менеджер
Plug 'vim-airline/vim-airline'     " Улучшенная строка состояния
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'        " Комментирование кода
Plug 'tpope/vim-surround'          " Работа с окружениями
Plug 'airblade/vim-gitgutter'      " Показать изменения Git
Plug 'jiangmiao/auto-pairs'        " Автозакрытие скобок

" Цветовые схемы
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'

call plug#end()

" Настройки плагинов
let g:airline_theme='onedark'
colorscheme onedark

" Включить номера строк
set number
