(import-macros {: augroup!}
               :hibiscus.vim)

(augroup! :filetype-detect
  [[BufNewFile BufRead] *.zuo "setf racket.zuo"])

