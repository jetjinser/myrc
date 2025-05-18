(import-macros {: map!} :hibiscus.vim)

(set vim.g.mapleader ",")

(map! [n] :j :gj)
(map! [n] :gj :j)
(map! [n] :k :gk)
(map! [n] :gk :k)

(map! [ci] "<Backspace>" "<NOP>")

(map! [n] "<C-c>" ":cclose<CR>")
