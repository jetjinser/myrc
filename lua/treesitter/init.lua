require("treesitter.neorg")
-- require("treesitter.autopairs")

require("nvim-treesitter.configs").setup {
    ensure_installed = {
        "norg",
        "norg_meta",
        "norg_table",
        "rust"
    },
    highlight = {
        enable = true,
        -- conceal: might be true
        -- additional_vim_regex_highlighting = true,
    },
    indent = {
        enable = true,
    },
    rainbow = {
        enable = true,
    },
    -- nvim-treesitter/nvim-treesitter-refactor
    refactor = {
        highlight_definitions = {
            enable = true,
            clear_on_cursor_move = true
        },
        highlight_current_scope = {
            enable = false
        },
    },
}
