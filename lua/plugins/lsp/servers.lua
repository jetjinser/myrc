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
  eslint = {},
  tsserver = {},
}
