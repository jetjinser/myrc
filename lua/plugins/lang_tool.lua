local on_attach = require("plugins.lsp.keymaps").on_attach

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
    ft = { "clojure", "fennel", "racket", "python", "scheme" },
    config = function(_, _opts)
      vim.g["conjure#mapping#prefix"] = ";"
      vim.g["conjure#filetype"] = { "clojure", "fennel", "racket", "scheme" }

      vim.g["conjure#filetype#scheme"] = "conjure.client.guile.socket"

      require("conjure.main").main()
      require("conjure.mapping")["on-filetype"]()
    end,
  },

  {
    "https://github.com/Julian/lean.nvim",
    ft = { "lean" },
    opts = {
      lsp = {
        on_attach = on_attach,
      },
      mappings = true,
    },
    config = function(_, opts)
      require("lean").setup(opts)
    end,
  },

  {
    "https://gitlab.com/HiPhish/guile.vim",
  },

  {
    "jetjinser/forester.nvim",
    branch = "de-telescope",
    ft = { "forester", "tree" },
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" },
      { "nvim-lua/plenary.nvim" },
      { "hrsh7th/nvim-cmp" },
    },
    opts = {
      -- global forests
      forests = { "~/life/writing/forest/" },
      -- where the plugin will look for trees. Works outside of global forests
      tree_dirs = { "trees", "notes" },
      -- Concealing is highly experimental, incomplete, partially broken. Enable only if you want to improve it!
      conceal = false,
    },
    config = function(_, opts)
      require("forester").setup(opts)

      vim.cmd [[
        hi link @field @Tag
        hi link @text @keyword
        hi link @spell Normal
        hi link @include Include
      ]]
    end,
    keys = {
      -- { "<leader>t.", "<cmd>Forester browse<CR>", desc = "Telescope picker, search trees by title" },
      { "<leader>tn", "<cmd>Forester new<CR>",        desc = "Create a new tree by specifying a prefix", silent = true },
      { "<C-t>",      "<cmd>Forester transclude<CR>", mode = "i",                                        desc = "Transclude a new tree at cursor position", silent = true },
      { "<C-l>",      "<cmd>Forester link<CR>",       mode = "i",                                        desc = "Link a new tree at cursor position",       silent = true },
    },
  },
}
