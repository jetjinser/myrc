" plugins {{{
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kien/rainbow_parentheses.vim'
Plug 'wakatime/vim-wakatime'
Plug 'jpalardy/vim-slime', { 'for': ['python', 'julia']}
Plug 'psliwka/vim-smoothie'
Plug 'itchyny/vim-cursorword'
Plug 'cespare/vim-toml'
Plug 'tpope/vim-commentary'
Plug 'voldikss/vim-floaterm'
Plug 'lervag/vimtex'

" 特定语言语法高亮
Plug 'bakpakin/fennel.vim'
Plug 'udalov/kotlin-vim'

" themes
Plug 'dracula/vim', { 'as': 'dracula' }

" 我不会用 😭
" Plug 'mg979/vim-visual-multi', {'branch': 'master'}

call plug#end()
" }}}

" mappings {{{
" about coc {{{
nnoremap <space>e :CocCommand explorer<CR>

nnoremap <silent> W :call <SID>show_documentation()<CR>

" 回车时格式化
inoremap <silent><expr> <cr> "\<C-g>u\<CR>\<c-r>=coc#on_enter()\"<CR>"

" coc-translator
" popup
nmap <Leader>t <Plug>(coc-translator-p)
vmap <Leader>t <Plug>(coc-translator-pv)

"  tab 触发补全
inoremap <silent><expr> <Tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<Tab>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
let g:coc_snippet_next='<S-Tab>'
let g:coc_snippet_prev='<Tab>'

" 重命名
nmap <leader>rn <Plug>(coc-rename)
nmap <silent> ga <Plug>(coc-codeaction-line)

" 高亮选中
autocmd CursorHold * silent call CocActionAsync('highlight')

" 格式化代码
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Remap <C-f> and <C-b> for scroll float windows/popups.
" if has('nvim-0.4.0') || has('patch-8.2.0750')
"    nmap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"    nmap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"    nmap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"    nmap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
"    nmap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"    nmap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"endif

" trigger completion
inoremap <silent><expr> <leader>p coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :call CocAction('jumpDefinition', 'drop')<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" }}}

" about vim-plug {{{
augroup PlugHelp
    autocmd!
    autocmd FileType vim-plug nnoremap <buffer> <silent> H :call <sid>plug_doc()<cr>
augroup END

augroup PlugGx
    autocmd!
    autocmd FileType vim-plug nnoremap <buffer> <silent> gx :call <sid>plug_gx()<cr>
augroup END
" }}}

" General {{{
command! -nargs=0 Conf :tabnew ~/.config/nvim/init.vim
command! -nargs=0 Stri :%s/\s\+$//
" }}}
" }}}

" General settings {{{

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

set encoding=utf-8

" 设置 tab 和缩进为4空格
set tabstop=4
set shiftwidth=4
set softtabstop=0
set expandtab

" 按照标记自动折叠
" augroup auto_fold
"     autocmd!
"     autocmd FileType vim set foldmethod=marker
"     set foldmethod=manual
" augroup END
set foldmethod=marker

" 相对行号
set nu
set rnu
augroup relative_numbser
    autocmd!
    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :set relativenumber
augroup END

" 真彩
set t_Co=256
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

" 高亮光标所在行
set cursorline

" https://superuser.com/questions/302186/vim-scrolls-very-slowly-when-a-line-is-too-long
set synmaxcol=500
" }}}

" vim-plug settings {{{
augroup highlight
    autocmd!
    autocmd InsertEnter <buffer> let g:cursorword=0
    autocmd InsertLeave <buffer> let g:cursorword=1
augroup END

colorscheme dracula

" airline {{{
let g:airline#extensions#tabline#enabled = 1
" }}}
" }}}

" Coc settings {{{
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" coc-pairs
autocmd FileType tex let b:coc_pairs = [["$", "$"]]

" coc-vimlsp
let g:markdown_fenced_languages = [
            \ 'vim',
            \ 'help'
            \]
" }}}

" functions {{{
function! s:plug_doc()
    let name = matchstr(getline('.'), '^- \zs\S\+\ze:')
    if has_key(g:plugs, name)
        for doc in split(globpath(g:plugs[name].dir, 'doc/*.txt'), '\n')
            execute 'tabe' doc
        endfor
    endif
endfunction

function! s:plug_gx()
    let line = getline('.')
    let sha  = matchstr(line, '^  \X*\zs\x\{7,9}\ze ')
    let name = empty(sha) ? matchstr(line, '^[-x+] \zs[^:]\+\ze:')
                \ : getline(search('^- .*:$', 'bn'))[2:-2]
    let uri  = get(get(g:plugs, name, {}), 'uri', '')
    if uri !~ 'github.com'
        return
    endif
    let repo = matchstr(uri, '[^:/]*/'.name)
    let url  = empty(sha) ? 'https://github.com/'.repo
                \ : printf('https://github.com/%s/commit/%s', repo, sha)
    call netrw#BrowseX(url, 0)
endfunction

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction
" }}}
