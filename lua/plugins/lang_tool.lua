return {
  {
    "isovector/cornelis",
    ft = { "agda" },
    build = "stack build",
    dependencies = {
      "kana/vim-textobj-user",
      "neovimhaskell/nvim-hs.vim",
    },
  },

  {
    "Olical/conjure",
    ft = { "clojure", "fennel", "racket", "python" },
    config = function(_, _opts)
      vim.g["conjure#mapping#prefix"] = ";"
      vim.g["conjure#filetype"] = { "clojure", "fennel", "racket" }

      require("conjure.main").main()
      require("conjure.mapping")["on-filetype"]()
    end,
  }
}
