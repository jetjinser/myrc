local ts_config = require("nvim-treesitter.configs")
local ts_ctx_config = require("treesitter-context")

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

vim.cmd [[highlight TreesitterContext guibg=grey30]]
ts_ctx_config.setup{
    enable = true,
    throttle = true,
    max_lines = 0,
    patterns = {
        default = {
            'class',
            'function',
            'method',
        },
    },
}
