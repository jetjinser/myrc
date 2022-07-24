local on_attach = require("lsp.attach").on_attach
local lsp = require("lspconfig")

lsp.hls.setup {
    on_attach = on_attach,
    settings = {
        formattingProvider = "ormolu"
    },
}

lsp.rust_analyzer.setup{
    on_attach = on_attach,
}
