local servers = require("plugins.lsp.servers")

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
        virtual_text = { spacing = 4, prefix = "●" },
        severity_sort = true,
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

      for server, server_opts in pairs(opts.servers) do
        server_opts.capabilities = capabilities
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
    opts = function()
      local nls = require("null-ls")
      return {
        sources = {
          nls.builtins.diagnostics.checkmake,
          -- LaTeX
          nls.builtins.diagnostics.chktex,
          nls.builtins.diagnostics.editorconfig_checker,
          nls.builtins.diagnostics.fish,
          nls.builtins.diagnostics.gitlint,
          nls.builtins.diagnostics.sqlfluff.with({
            extra_args = { "--dialect", "postgres" }, -- change to your dialect
          }),

          nls.builtins.completion.luasnip,

          -- nix lang
          -- nls.builtins.code_actions.statix,
          nls.builtins.code_actions.gitsigns,
        },
      }
    end,
  },
}