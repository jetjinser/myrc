local border = {
    { "╭", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╮", "FloatBorder" },
    { "│", "FloatBorder" },
    { "╯", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╰", "FloatBorder" },
    { "│", "FloatBorder" },
}

local on_attach = function(_client, bufnr)

    -- hightlight {{{
    vim.cmd([[autocmd ColorScheme * highlight NormalFloat guibg=#1f2335]])
    vim.cmd([[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]])

    vim.cmd([[
    hi link DiagnosticVirtualTextError NightflyRedAlert
    hi link DiagnosticVirtualTextWarn NightflyTan
    hi link DiagnosticVirtualTextInfo NightflyBlueAlert
    hi link DiagnosticVirtualTextHint NightflyGreen

    " Underline the offending code
    hi DiagnosticUnderlineError guifg=NONE ctermfg=NONE cterm=underline gui=underline
    hi DiagnosticUnderlineWarn guifg=NONE ctermfg=NONE cterm=underline gui=underline
    hi DiagnosticUnderlineInfo guifg=NONE ctermfg=NONE cterm=underline gui=underline
    hi DiagnosticUnderlineHint guifg=NONE ctermfg=NONE cterm=underline gui=underline

    sign define DiagnosticSignError text= texthl=LspDiagnosticsUnderlineError numhl=NightflyRedAlert
    sign define DiagnosticSignWarn text= texthl=LspDiagnosticsSignWarning numhl=NightflyTan
    sign define DiagnosticSignInfo text= texthl=LspDiagnosticsSignInformation numhl=NightflyBlueAlert
    sign define DiagnosticSignHint text= texthl=NightflyGreen numhl=NightflyGreen
    ]])
    -- }}}

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = border,
    })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = border,
    })

    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    local opts = { noremap = true, silent = true }

    -- keymap {{{
    buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "W", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.setloclist()<CR>", opts)
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    -- }}}
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
        "●",
    },
    signs = true,
    underline = false,
    update_in_insert = false,
})


-- on_server_ready {{{

local lsp_installer = require("nvim-lsp-installer")

local enhance_server_opts = {
    ["sumneko_lua"] = function(opts)
        opts.cmd = {
            "lua-language-server", "--preview"
        }
    end,
}

lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        },
    }

    if enhance_server_opts[server.name] then
        enhance_server_opts[server.name](opts)
    end

    -- Initialize the LSP via rust-tools instead
    -- FIXME: codelldb.so, 9: image not found
    if server.name == "rust_analyzer" then
        local extension_path = vim.fn.stdpath("data") .. "/visx/codelldb-x86_64-darwin/extension/"
        local codelldb_path = extension_path .. "adapter/codelldb"
        local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

        require("rust-tools").setup {
            server = vim.tbl_deep_extend("force", server:get_default_options(), opts),
            dap = {
                adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
            },
            tools = {
                crate_graph = {
                    -- x11 not recognized, it said
                    backend = "plain"
                },
                executor = require("rust-tools/executors").quickfix
            }
        }
        server:attach_buffers()
    else
        server:setup(opts)
    end
end)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" },
}

-- }}}
