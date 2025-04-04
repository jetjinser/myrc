---@class ParserInfo[]
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.d2 = {
  install_info = {
    url = "https://github.com/ravsii/tree-sitter-d2",
    files = { "src/parser.c" },
    branch = "main"
  },
  filetype = "d2",
}
-- parser_config.lean = {
--   install_info = {
--     url = "https://github.com/Julian/tree-sitter-lean",
--     files = { "src/parser.c" },
--     branch = "main"
--   },
--   filetype = "lean",
-- }

-- parser_config.moonbit = {
--   install_info = {
--     url = "https://github.com/jetjinser/tree-sitter-moonbit",
--     files = { "src/parser.c" },
--     branch = "queries",
--   },
-- }

-- parser_config.forester = {
--   install_info = {
--     url = "https://github.com/kentookura/tree-sitter-forester",
--     files = { "src/parser.c" },
--     branch = "main",
--     generate_requires_npm = false,
--     requires_generate_from_grammar = false,
--   },
--   filetype = "tree",
--   register("forester", "forester")
-- }
