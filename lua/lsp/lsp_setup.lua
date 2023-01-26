local on_attach = require("lsp.attach").on_attach
local lsp = require("lspconfig")

lsp.hls.setup {
    on_attach = on_attach,
    settings = {
        formattingProvider = "ormolu"
    },
}

lsp.clangd.setup {
    on_attach = on_attach,
}

lsp.rust_analyzer.setup {
    on_attach = on_attach,
}

lsp.rnix.setup {
    on_attach = on_attach,
}

lsp.racket_langserver.setup {
    on_attach = on_attach,
    settings = {
        filetypes = {
            "racket",
        },
    },
}

lsp.html.setup {
    on_attach = on_attach,
}

lsp.svelte.setup {
    on_attach = on_attach,
}


lsp.jsonls.setup {
    on_attach = on_attach,
}

-- lsp.jdtls.setup {
--     on_attach = on_attach,
--     cmd = { "jdt-language-server", "-configuration", "/home/runner/.cache/jdtls/config", "-data", "/home/runner/.cache/jdtls/workspace" }
-- }

lsp.sumneko_lua.setup {
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = {
                    "vim",
                },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
}

lsp.texlab.setup {
    on_attach = on_attach,
}

lsp.zls.setup {
    on_attach = on_attach
}
