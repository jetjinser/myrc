lua require('init')

let mapleader = ","

set termguicolors

set nu
set rnu
augroup relative_numbser
    autocmd!
    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :set relativenumber
augroup end

set cursorline

set tabstop=4
set shiftwidth=4
set softtabstop=0
set expandtab
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
