return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
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
      servers = {
        sumneko_lua = {
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
      },
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
}
