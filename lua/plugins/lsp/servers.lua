return {
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
  nil_ls = {
    formatting = {
      command = "nix fmt",
    },
  },
  hls = {
    filetypes = { "haskell", "lhaskell", "cabal" },
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
