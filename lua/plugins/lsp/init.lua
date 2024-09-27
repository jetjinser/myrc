local servers = require("plugins.lsp.servers")
local border = require("config").border

return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neodev.nvim",   opts = { experimental = { pathStrict = true } } },
      { "hrsh7th/cmp-nvim-lsp" },
    },
    ---@class PluginLspOpts
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          prefix = function(diagnostic, _i, _total)
            local severity = vim.diagnostic.severity
            local dia_icons = require("config").icons.diagnostics;
            local prefix_map = {
              [severity.ERROR] = dia_icons.Error,
              [severity.WARN] = dia_icons.Warn,
              [severity.INFO] = dia_icons.Info,
              [severity.HINT] = dia_icons.Hint,
            };
            return prefix_map[diagnostic.severity]
          end
        },
        severity_sort = true,
        float = { border = border },
      },
      -- LSP Server Settings
      servers = servers,
      -- rust-tool.nvim ready
      setup = {},
    },
    ---@param opts PluginLspOpts
    config = function(_plugin, opts)
      -- setup formatting and keymaps
      require("util").on_attach(function(client, buffer)
        require("plugins.lsp.keymaps").on_attach(client, buffer)
      end)

      -- diagnostics
      for name, icon in pairs(require("config").icons.diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end
      vim.diagnostic.config(opts.diagnostics)

      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      capabilities.offsetEncoding = { "utf-16" };
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
      }

      local handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
      }

      for server, server_opts in pairs(opts.servers) do
        server_opts.capabilities = capabilities
        server_opts.handlers = handlers;

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end
    end,
  },

  -- null-ls
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
    },
    opts = function()
      local nls = require("null-ls")
      return {
        debug = true,
        sources = {
          nls.builtins.diagnostics.checkmake,
          -- LaTeX
          nls.builtins.diagnostics.chktex,
          nls.builtins.diagnostics.fish,
          nls.builtins.diagnostics.gitlint,
          -- nls.builtins.diagnostics.sqlfluff.with({
          --   extra_args = { "--dialect", "postgres" },
          -- extra_args = { "--dialect", "sqlite" },
          -- }),
          -- nls.builtins.diagnostics.pylint.with({
          --   diagnostics_postprocess = function(dia)
          --     -- dia.code = dia.message_id .. "[" .. dia.code .. "]"
          --   end,
          -- }),
          nls.builtins.diagnostics.ruff,

          -- nix lang
          -- nls.builtins.code_actions.statix,
          nls.builtins.code_actions.gitsigns,

          -- LaTeX
          nls.builtins.formatting.latexindent,
          nls.builtins.formatting.black,
        },
      }
    end,
  },

  -- {
  --   dir    = "~/.config/nvim/explugins/lspower.nvim",
  --   config = function(_plugins, opts)
  --     require("lspower").setup(opts)
  --   end
  -- },

  -- {
  --   "ShinKage/idris2-nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  --   config = function(_plugin, _opts)
  --     require("idris2").setup {}
  --   end
  -- },
}
