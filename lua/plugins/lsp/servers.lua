return {
  gopls = {},
  jdtls = {},
  html = {},
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          unusedLocalExclude = {
            "_*"
          },
        },
      },
    },
  },
  rust_analyzer = {
    settings = {
      ['rust-analyzer'] = {
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
      ['nil'] = {
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
      },
    }
  },
  racket_langserver = {},
  arduino_language_server = {},
  eslint = {},
  tsserver = {},
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
