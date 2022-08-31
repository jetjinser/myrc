local luasnip = require("luasnip")
local cmp = require("cmp")

-- functions {{{
local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
        return false
    end
    local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local check_backspace = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local function T(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local tab = function()
    if cmp.visible() then
        cmp.confirm({ select = true })
    elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    elseif check_backspace() then
        vim.fn.feedkeys(T("<Tab>"), "n")
    else
        local copilot_keys = vim.fn["copilot#Accept"]()
        if copilot_keys ~= "" then
            vim.api.nvim_feedkeys(copilot_keys, "i", true)
        else
            vim.fn.feedkeys(T("<Tab>"), "n")
        end
    end
end

local s_tab = function()
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    end
end

--- }}}

-- setup crates
vim.cmd([[autocmd FileType toml lua require("cmp").setup.buffer { sources = { { name = "crates" } } }]])

-- setup {{{
cmp.setup({
    -- config {{{
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    window = {
        completion = {
            border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
        },
        documentation = {
            border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
        },
    },
    completion = {
        completeopt = "menu,menuone,noselect",
    },
    experimental = {
        ghost_text = false,
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            local icons = require("kind.icons").icons
            vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                nvim_lua = "[Lua]",
                luasnip = "[Spt]",
                crates = "[Cas]",
                buffer = "[Buf]",
                path = "[Pah]",
                neorg = "[Nrg]",
                latex_symbols = "[Syb]",
                emoji = "[emj]",
                digraphs = "[Dig]",
            })[entry.source.name]
            return vim_item
        end,
    },

    -- mapping {{{
    mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-w>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<Tab>"] = cmp.mapping({
            i = tab,
            s = tab,
            -- c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Replace }),
            -- c = function(fallback)
            --     if cmp.visible() then
            --         local entry = cmp.get_selected_entry()
            --         if not entry then
            --             cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            --         else
            --             cmp.confirm()
            --         end
            --     else
            --         fallback()
            --     end
            -- end
        }),
        ["<S-Tab>"] = cmp.mapping({
            i = s_tab,
            s = s_tab,
            -- c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Repace }),
            -- c = function(fallback)
            --     if cmp.visible() then
            --         local entry = cmp.get_selected_entry()
            --         if not entry then
            --             cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
            --         else
            --             cmp.confirm()
            --         end
            --     else
            --         fallback()
            --     end
            -- end
        }),

        ["<C-j>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif has_words_before() then
                cmp.complete()
            elseif luasnip.jumpable() then
                luasnip.jump(1)
            end
        end, {
            "i",
            "s",
        }),

        ["<C-k>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
    },
    -- }}}
    -- }}}

    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
        { name = "neorg" },
        -- {
        --     name = "rime",
        --     option = {
        --         shared_data_dir = "/home/jinser/share",
        --         user_data_dir = vim.fn.getenv("HOME") .. "/.local/share/cmp-rime",
        --         max_candidates = 10,
        --     }
        -- },
    },
})

cmp.setup.filetype({ "plaintex", "markdown" }, {
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
        { name = "latex_symbols" },
        { name = "emoji" },
        { name = "digraphs" },
    }
})

cmp.setup.cmdline(":", {
    completion = { autocomplete = true },
    sources = cmp.config.sources({
        { name = "path" }
    }, {
        { name = "cmdline" }
    })
})

cmp.setup.cmdline("/", {
    completion = { autocomplete = true },
    sources = {
        { name = "buffer" }
    }
})
-- }}}
