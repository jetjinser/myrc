(import-macros {: augroup!}
               :hibiscus.vim)

(augroup! :filetype-detect
  [[BufNewFile BufRead] *.zuo "setf racket"]
  [[BufNewFile BufRead] *.tree "setf latex"])

