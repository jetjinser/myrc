require("treesitter.neorg")

require("nvim-treesitter.configs").setup {
    ensure_installed = {
        "norg",
        "norg_meta",
        "norg_table"
    },
    playground = {
        enable = true,
    },
    highlight = {
        enable = true,
        -- conceal: might be true
        additional_vim_regex_highlighting = false,
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
        smart_rename = {
            enable = true,
            keymaps = {
                smart_rename = "<leader>rn"
            }
        },
        navigation = {
            enable = true,
            keymaps = {
                goto_definition_lsp_fallback = "gd",
                list_definitions = "gD",
                list_definitions_toc = "gO",
                goto_next_usage = "]d",
                goto_previous_usage = "[d"
            }
        }
    },
    context_commentstring = {
        enable = true
    }
}
