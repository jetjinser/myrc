require("config.options")
require("config.map")
require("config.filetype")
require("config.autocmds")
require("config.user_cmds")

local M = {}

M.icons = {
  diagnostics = {
    Error = "󰋔 ",
    Warn = " ",
    Hint = "󰌶 ",
    Info = "󰙎 ",
  },
  git = {
    added = " ",
    modified = " ",
    removed = " ",
  },
  kinds = {
    Array = " ",
    Boolean = " ",
    Class = " ",
    Color = " ",
    Constant = " ",
    Constructor = " ",
    Copilot = "",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = " ",
    Interface = " ",
    Key = " ",
    Keyword = " ",
    Method = " ",
    Module = " ",
    Namespace = " ",
    Null = "ﳠ ",
    Number = " ",
    Object = " ",
    Operator = " ",
    Package = " ",
    Property = " ",
    Reference = " ",
    Snippet = " ",
    String = " ",
    Struct = " ",
    Text = "󰦨 ",
    TypeParameter = " ",
    Unit = " ",
    Value = " ",
    Variable = " ",
  },
}

M.border = {
  -- "┌", "─", "┐", "│", "┘", "─", "└", "│",
  "╭", "─", "╮", "│", "╯", "─", "╰", "│",
}

return M
