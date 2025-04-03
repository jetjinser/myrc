return {
  elp = {},
  janet_lsp = {},
  ocamllsp = {},
  tinymist = {},
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
        },
        cargo = {
          cfgs = { "kani" },
        },
        completion = {
          termSearch = { enable = true, },
        },
        hover = {
          memoryLayout = { niches = true, },
        },
        inlayHints = {
          -- Whether to show inlay type hints for binding modes
          bindingModeHints = { enable = true, },
          -- Whether to show inlay hints for closure captures
          closureCaptureHints = { enable = true, },
          -- Whether to show inlay type hints for return types of closures
          -- closureReturnTypeHints = { enable = true, },
          -- Whether to show enum variant discriminant hints
          -- discriminantHints = { enable = true, },
          -- Whether to show inlay hints for type adjustments
          expressionAdjustmentHints = { enable = true, },
          genericParameterHints = {
            -- Whether to show generic lifetime parameter name inlay hints
            lifetime = { enable = true, },
            -- Whether to show generic type parameter name inlay hints
            -- type = { enable = true, },
          },
          -- Whether to show implicit drop hints
          -- implicitDrops = { enable = true, },
          -- Whether to show inlay hints for the implied type parameter Sized bound
          -- implicitSizedBoundHints = { enable = true, },
          -- Whether to show inlay type hints for elided lifetimes in function signatures
          lifetimeElisionHints = { enable = true, },
          -- Whether to show exclusive range inlay hints
          rangeExclusiveHints = { enable = true, },
        },
        lens = { enable = false, },
        semanticHighlighting = {
          operator = {
            specialization = { enable = true, },
            punctuation = { enable = true, },
          },
        },
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
          command = { "nixfmt" },
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
            inlayHintsOn = true,
          },
        },
      },
    },
  },
  racket_langserver = {
    filetypes = { "racket", "rhombus", "scribble" },
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
