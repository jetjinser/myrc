lua require('init')

let mapleader = ","

inoremap jk <esc>
inoremap <esc> <NOP>

inoremap <C-h> <C-k>

set foldmethod=marker
set nowrap

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
