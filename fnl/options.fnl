(import-macros {: set! : set+ : augroup! : color!}
               :hibiscus.vim)

;; Line numbers
(set! number)
(set! relativenumber)
(augroup! :relative-number-on-insert
  [[InsertEnter] * '(set! norelativenumber)]
  [[InsertLeave] * '(set! relativenumber)])

;; Indentation
(set! expandtab)
(set! softtabstop 0)
(set! tabstop     2)
(set! shiftwidth  2)

;; Whitespace
(set! list)

;; Disable mouse
(set! mouse "")

;; Disable mouse scroll
(set vim.g.mousescroll "ver:0,hor:0")

;; Cursor
(set! cursorline)

;; Window
(set! winborder :single)

;; netrw
(let [g vim.g]
  (set g.netrw_liststyle 3)
  (set g.netrw_banner 0)
  (set g.netrw_browse_split 4)
  (set g.netrw_winsize 25))

(set+ nrformats :blank)

;; smart case
(set! ignorecase)
(set! smartcase)

;; grepprg
(when (= (vim.fn.executable :rg) 1)
  ;; default with `-uu`,
  ;; equivalent to `--no-ignore -./--hidden`
  (set vim.o.grepprg "rg --vimgrep "))

;; Disable unused builtin plugins
(let [g vim.g]
  (set g.loaded_tutor_mode_plugin 1)
  (set g.loaded_netrwPlugin 1))
