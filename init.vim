inoremap jk <esc>

" set foldmethod=marker

set nu
set rnu
augroup relative_numbser
    autocmd!
    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :set relativenumber
augroup end

set cursorline
set termguicolors

set tabstop=2
set shiftwidth=2
set softtabstop=0
set expandtab

set mouse=

lua require('init')
