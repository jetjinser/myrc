return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "<C-space>", desc = "Increment selection" },
      { "<bs>",      desc = "Schrink selection",  mode = "x" },
    },
    --- @type TSConfig
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = "<nop>",
          node_decremental = "<bs>",
        },
      },
      ensure_installed = {
        "vimdoc",
        "luadoc",
        "vim",
        "lua",
        "markdown"
      }
    },
    --- @param opts TSConfig
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,

    init = function()
      local register = vim.treesitter.language.register;

      require("plugins.treesitter.custom_parser");

      register("racket", "conjure-rkt")
      register("racket", "zuo")
      register("racket", "rhombus")
      register("python", "conjure-py")

      register("forester", "tree")
    end,
  },
}
