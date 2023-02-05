let mapleader = ","

inoremap jk <esc>
inoremap <esc> <NOP>

set foldmethod=marker

set nu
set rnu
augroup relative_numbser
    autocmd!
    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :set relativenumber
augroup end

set cursorline
set termguicolors

set tabstop=4
set shiftwidth=4
set softtabstop=0
set expandtab

lua require('init')
