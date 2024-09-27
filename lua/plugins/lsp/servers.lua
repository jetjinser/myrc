return {
  ocamllsp = {},
  typst_lsp = {},
  svelte = {},
  cssls = {},
  -- emmet_ls = {},
  gopls = {},
  jdtls = {},
  kotlin_language_server = {},
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
          ["semanticTokens"] = {
            globalOn = true,
          },
          ["importLens"] = {
            codeLensOn = false,
            inlayHintsOn = false,
          },
        },
      },
    },
  },
  racket_langserver = {
    filetypes = { "racket" },
  },
  arduino_language_server = {},
  eslint = {},
  -- volar = {
  --   filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
  -- },
  ts_ls = {
  -- init_options = {
  --   plugins = {
  --     {
  --       name = '@vue/typescript-plugin',
  --       location = "$HOME/vie/projet/hw/landing-foodie/node_modules/@vue/language-core/",
  --       languages = { "vue" },
  --     },
  --   },
  -- },
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
  },
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
