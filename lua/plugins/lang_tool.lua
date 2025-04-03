local on_attach = require("plugins.lsp.keymaps").on_attach

return {
  {
    "ryleelyman/latex.nvim",
    ft = { "tex", "plaintex" },
    config = true,
    opts = {
      conceals = {
        add = {
          ["textdollar"] = "$",
          ["textyen"] = "¥",
        },
      },
    },
  },

  "zoomlogo/vim-apl",

  {
    "sersorrel/vim-lilypond",
    ft = { "lilypond" },
  },

  -- {
  --   "isovector/cornelis",
  --   ft = { "agda" },
  --   build = "stack build",
  --   dependencies = {
  --     "kana/vim-textobj-user",
  --     "neovimhaskell/nvim-hs.vim",
  --   },
  -- },

  {
    "moonbit-community/moonbit.nvim",
    ft = { "moonbit" },
    opts = {
      treesitter = { enabled = true },
      -- configure the language server integration
      -- lsp = false,
      lsp = {
        -- provide an `on_attach` function to run when the language server starts
        on_attach = on_attach,
        -- provide client capabilities to pass to the language server
        capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        handlers = {
          ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = require("config").border }),
          ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help,
            { border = require("config").border }
          ),
        },
      }
    },
  },

  { "nfnty/vim-nftables", },

  {
    "Olical/conjure",
    ft = { "clojure", "fennel", "scheme" },
    lazy = true,
    init = function()
      vim.g["conjure#mapping#prefix"] = ";"
      vim.g["conjure#filetype"] = { "clojure", "fennel", "scheme" }
      vim.g["conjure#filetype#scheme"] = "conjure.client.guile.socket"
    end,
  },

  {
    "https://github.com/Julian/lean.nvim",
    ft = { "lean" },
    opts = {
      lsp = {
        on_attach = on_attach,
        -- provide client capabilities to pass to the language server
        capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        handlers = {
          ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = require("config").border }),
          ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help,
            { border = require("config").border }
          ),
        },
      },
      mappings = true,
    },
    config = function(_, opts)
      require("lean").setup(opts)
    end,
  },

  { "https://gitlab.com/HiPhish/guile.vim", },

  { "https://github.com/elkowar/yuck.vim", },

  -- {
  --   "jetjinser/forester.nvim",
  --   branch = "de-telescope",
  --   ft = { "forester", "tree" },
  --   opts = {
  --     -- global forests
  --     forests = { "~/life/writing/forest/" },
  --     -- where the plugin will look for trees. Works outside of global forests
  --     tree_dirs = { "trees", "notes" },
  --     -- Concealing is highly experimental, incomplete, partially broken. Enable only if you want to improve it!
  --     conceal = false,
  --   },
  --   config = function(_, opts)
  --     require("forester").setup(opts)
  --
  --     vim.cmd [[
  --       hi link @field @Tag
  --       hi link @text @keyword
  --       hi link @spell Normal
  --       hi link @include Include
  --     ]]
  --   end,
  --   keys = {
  --     -- { "<leader>t.", "<cmd>Forester browse<CR>", desc = "Telescope picker, search trees by title" },
  --     { "<leader>tn", "<cmd>Forester new<CR>",        desc = "Create a new tree by specifying a prefix", silent = true },
  --     { "<C-t>",      "<cmd>Forester transclude<CR>", mode = "i",                                        desc = "Transclude a new tree at cursor position", silent = true },
  --     { "<C-l>",      "<cmd>Forester link<CR>",       mode = "i",                                        desc = "Link a new tree at cursor position",       silent = true },
  --   },
  -- },

  -- {
  --   'akinsho/flutter-tools.nvim',
  --   config = true,
  -- }
}
