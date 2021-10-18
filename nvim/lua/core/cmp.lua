local luasnip = require("luasnip")
local cmp = require'cmp'

local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
        return false
    end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local function T(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

vim.cmd [[autocmd FileType toml lua require('cmp').setup.buffer { sources = { { name = 'crates' } } }]]

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    documentation = {
        border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"}
    },
    completion = {
        completeopt = "menu,menuone,noselect"
    },
    formatting = {
        format = function(entry, vim_item)
            local icons = require("kind.icons").icons
            vim_item.kind = icons[vim_item.kind]
            vim_item.menu = ({
                nvim_lsp = "(LSP)",
                nvim_lua = "(Lua)",
                luasnip = "(Snippet)",
                crates = "(Crates)",
                buffer = "(Buffer)",
                path = "(Path)",
                latex_symbols = "(LaTeX)",
                emoji = "(Emoji)",
                calc = "(Calc)",
                -- look = "(Look)",
                -- spell = "(Spell)",
            })[entry.source.name]
            return vim_item
        end
    },
    mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-w>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        -- FIXME cannot feed keys <Tab> before word because exec order
        ['<Tab>'] = cmp.mapping(function()
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.confirm({select = true})
            elseif check_backspace() then
                vim.fn.feedkeys(T "<Tab>", "n")
            else
                vim.fn.feedkeys(T "<Tab>", "n")
            end
        end, {"i", "s"}),
        ['<S-Tab'] = cmp.mapping(function()
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            end
        end, {"i", "s"}),

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
        end, {"i", "s"}),

        ["<C-k>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {"i", "s"})
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
        { name = "latex_symbols" },
        { name = "emoji" },
        { name = "calc" }
        -- { name='look', keyword_length=2 }
        -- { name = "spell" }
    }
})

-- vim.opt.spell = true
-- vim.opt.spelllang = { "en_us", "cjk" }


require("luasnip/loaders/from_vscode").lazy_load()

require('nvim-autopairs').setup()
require("nvim-autopairs.completion.cmp").setup({
  map_cr = true,
  map_complete = true,
  auto_select = true,
  insert = false,
})
