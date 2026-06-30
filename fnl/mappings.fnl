(import-macros {: map!} :hibiscus.vim)

(set vim.g.mapleader ",")

(map! [n] :j :gj)
(map! [n] :gj :j)
(map! [n] :k :gk)
(map! [n] :gk :k)

(map! [n] "<C-c>" ":cclose<CR>")

(map! [n] "gD"
      #(let [cword (vim.fn.expand "<cword>")]
         (vim.cmd (.. "grep " (vim.fn.escape cword " \"#$%&'()*+,-./:;<=>?@[\\]^`{|}~"))))
      "Grep current word under cursor")
(map! [v] "gD"
      #(do
         (vim.cmd "normal! \"zy")
         (let [text (vim.fn.getreg "z")
               escaped-text (vim.fn.escape text " \"#$%&'()*+,-./:;<=>?@[\\]^`{|}~")]
           (vim.cmd (.. "grep " escaped-text))))
      "Grep current visual selection")
