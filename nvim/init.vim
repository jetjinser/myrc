lua require('init')

let mapleader = ","

inoremap jk <esc>
inoremap <esc> <NOP>

set rtp+=/usr/local/opt/fzf

if has('nvim') && !empty($CONDA_PREFIX)
  let g:python3_host_prog = $CONDA_PREFIX . '/bin/python'
endif

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
