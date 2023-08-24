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
  rust_analyzer = {},
  clangd = {},
  nil_ls = {
    formatting = { command = { "nixpkgs-fmt" } }
  },
  hls = {
    filetypes = { "haskell", "lhaskell", "cabal" },
  },
  eslint = {},
  tsserver = {},

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
