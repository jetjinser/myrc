return {
  emmet_ls = {},
  gopls = {},
  jdtls = {},
  html = {},
  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          unusedLocalExclude = {
            "_*"
          },
          globals = {
            "vim",
          },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          allTargets = false,
        }
      }
    }
  },
  clangd = {},
  dartls = {},
  nickel_ls = {},
  nil_ls = {
    settings = {
      ["nil"] = {
        formatting = {
          command = { "nixpkgs-fmt" },
        },
      },
    },
  },
  hls = {
    filetypes = { "haskell", "lhaskell", "cabal" },
    settings = {
      haskell = {
        formattingProvider = "stylish-haskell",
        plugin = {
          ["inlay-hints"] = {
            config = {
              all = true,
              -- fixity = true,
              -- localBinding = true,
              -- hole = true,
            },
          },
        },
      },
    },
  },
  racket_langserver = {},
  arduino_language_server = {},
  eslint = {},
  volar = {
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" }
  },
  -- tsserver = {},
  -- denols = {},

  -- ruff_lsp = {},
  -- pylyzer = {},
  -- pylsp = {
  --   plugins = {
  --     configurationSources = {
  --       "pycodestyle",
  --       "flake8",
  --       "yapf",
  --       "rope_completion",
  --     },
  --     autopep8 = {
  --       enabled = false,
  --     },
  --     flake8 = {
  --       enabled = true,
  --     },
  --     yapf = {
  --       enabled = true,
  --     },
  --     rope_completion = {
  --       enabled = true,
  --     },
  --   }
  -- },
  pyright = {}
}
