(import-macros {: map!} :hibiscus.vim)

(set vim.g.mapleader ",")

(map! [n] :j :gj)
(map! [n] :gj :j)
(map! [n] :k :gk)
(map! [n] :gk :k)

(map! [n] "<C-c>" ":cclose<CR>")
