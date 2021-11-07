local ts_config = require("nvim-treesitter.configs")
local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

ts_config.setup({
	ensure_installed = "maintained",
	highlight = {
		enable = true,
		use_languagetree = true,
		additional_vim_regex_highlighting = {
            "haskell",
        },
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
		enable = true,
	},
})

parser_configs.norg = {
	install_info = {
		url = "https://github.com/nvim-neorg/tree-sitter-norg",
		files = { "src/parser.c", "src/scanner.cc" },
		branch = "main",
	},
}

local npairs = require("nvim-autopairs")

npairs.setup({
	check_ts = true,
})
