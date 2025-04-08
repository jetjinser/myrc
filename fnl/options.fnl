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

;; Cursor
(set! cursorline)

;; Theme
(color! :lunaperche)

;; Window
(set! winborder "shadow")
