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
    ft = { "clojure", "fennel", "racket" },
    dependencies = {
      "wlangstroth/vim-racket",
    },
    config = function(_, _opts)
      require("conjure.main").main()
      require("conjure.mapping")["on-filetype"]()
    end,
    init = function()
      vim.g["conjure#mapping#prefix"] = ";"
    end,
  }
}
