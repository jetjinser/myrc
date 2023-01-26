local _M = {}

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

function _M.on_attach(client, bufnr)
    -- hightlight {{{
    vim.cmd [[autocmd ColorScheme * highlight NormalFloat guibg=#1f2335]]
    vim.cmd [[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

    vim.cmd [[
        hi link DiagnosticVirtualTextError NightflyRedAlert
        hi link DiagnosticVirtualTextWarn NightflyTan
        hi link DiagnosticVirtualTextInfo NightflyBlueAlert
        hi link DiagnosticVirtualTextHint NightflyGreen

        " Underline the offending code
        hi DiagnosticUnderlineError guifg=NONE ctermfg=NONE cterm=underline gui=underline
        hi DiagnosticUnderlineWarn guifg=NONE ctermfg=NONE cterm=underline gui=underline
        hi DiagnosticUnderlineInfo guifg=NONE ctermfg=NONE cterm=underline gui=underline
        hi DiagnosticUnderlineHint guifg=NONE ctermfg=NONE cterm=underline gui=underline
    ]]

    vim.fn.sign_define(
        "DiagnosticSignError",
        { texthl = "DiagnosticSignError", text = "", numhl = "DiagnosticSignError" }
    )
    vim.fn.sign_define(
        "DiagnosticSignWarn",
        { texthl = "DiagnosticSignWarn", text = "", numhl = "DiagnosticSignWarn" }
    )
    vim.fn.sign_define(
        "DiagnosticSignHint",
        { texthl = "DiagnosticSignHint", text = "", numhl = "DiagnosticSignHint" }
    )
    vim.fn.sign_define(
        "DiagnosticSignInfo",
        { texthl = "DiagnosticSignInfo", text = "", numhl = "DiagnosticSignInfo" }
    )
    -- }}}

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = border,
    })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = border,
    })

    local function buf_set_keymap(mode, lhs, rhs)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- keymap {{{
    buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
    -- buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
    -- buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
    -- buf_set_keymap("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>")

    -- buf_set_keymap("n", "W", "<cmd>lua vim.lsp.buf.hover()<CR>")
    buf_set_keymap("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")

    -- workspace
    buf_set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
    buf_set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
    buf_set_keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")

    buf_set_keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>")

    buf_set_keymap("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>")
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format { async = true }<CR>")

    -- Lspsaga
    buf_set_keymap("n", "<leader>rn", "<cmd>Lspsaga rename ++project<CR>")

    buf_set_keymap("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>")
    buf_set_keymap("n", "<leader>cD", "<cmd>Lspsaga show_line_diagnostics<CR>")
    buf_set_keymap("n", "<leader>cb", "<cmd>Lspsaga show_buf_diagnostics<CR>")

    buf_set_keymap("n", "<leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
    buf_set_keymap("n", "<leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

    buf_set_keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")
    buf_set_keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")

    buf_set_keymap("n", "]e", function()
        require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
    end)
    buf_set_keymap("n", "[e", function()
        require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end)

    buf_set_keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>")
    buf_set_keymap("n", "W", "<cmd>Lspsaga hover_doc<CR>")

    buf_set_keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>")
    buf_set_keymap("v", "<leader>ca", "<cmd>Lspsaga code_action<CR>")

    buf_set_keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")
    buf_set_keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>")
    buf_set_keymap("n", "<leader>gd", "<cmd>Lspsaga goto_definition<CR>")

    buf_set_keymap("n", "<M-q>o", "<cmd>Lspsaga open_floaterm<CR>")
    buf_set_keymap("n", "<M-q>g", "<cmd>Lspsaga open_floaterm lazygit<CR>")
    buf_set_keymap("t", "<M-q>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]])
    -- }}}

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
            virtual_text = {
                prefix = "●",
            },
            signs = true,
            underline = false,
            update_in_insert = false,
        })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = { "documentation", "detail", "additionalTextEdits" },
    }
end

return _M
