local ts_config = require("nvim-treesitter.configs")

ts_config.setup({
    ensure_installed = "maintained",
    highlight = {
        enable = true,
        use_languagetree = true,
        additional_vim_regex_highlighting = false,
    },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    },
    matchup = {
        enable = true,
    },
    autotag = {
        enable = false,
    },
    context_commentstring = {
        enable = true
    },
})

local npairs = require("nvim-autopairs")

npairs.setup({
    check_ts = true,
})
