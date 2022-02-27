lua require('init')

let mapleader = ","

inoremap jk <esc>
inoremap <esc> <NOP>

set rtp+=/usr/local/opt/fzf

" set termguicolors

" for chez scheme
let g:conjure#client#scheme#stdio#command = "petite"
let g:conjure#client#scheme#stdio#prompt_pattern = "> $?"

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
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
