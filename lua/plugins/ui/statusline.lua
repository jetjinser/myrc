local _lsp_progress = {
  "lsp_progress",
  -- display_components = { "lsp_client_name", "spinner", { "title", "percentage", "message" } },
  display_components = { "spinner", { "title", "percentage", "message" } },
  separators = {
    component = " ",
    progress = " | ",
    message = { pre = "(", post = ")" },
    percentage = { pre = "", post = "%% " },
    title = { pre = "", post = ": " },
    lsp_client_name = { pre = "[", post = "]" },
    spinner = { pre = "", post = "" },
  },
  timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
  spinner_symbols = { "🌑 ", "🌒 ", "🌓 ", "🌔 ", "🌕 ", "🌖 ", "🌗 ", "🌘 " },
};

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  -- dependencies = {
  --   { "arkav/lualine-lsp-progress" }
  -- },
  opts = function(_plugin)
    local icons = require("config").icons

    local function fg(name)
      return function()
        ---@type {foreground?:number}?
        local hl = vim.api.nvim_get_hl_by_name(name, true);
        return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
      end
    end

    return {
      options = {
        theme = "auto",
        globalstatus = true,
        section_separators = "",
        component_separators = "",
        disabled_filetypes = { statusline = { "lazy", "alpha" } },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          {
            "filetype",
            icon_only = true,
            separator = "",
            padding = {
              left = 1, right = 0
            }
          },
          {
            "filename",
            path = 1,
            symbols = {
              modified = "[*]",
              readonly = "󰌾",
              unnamed = ""
            }
          },
          -- stylua: ignore
          {
            function() return require("nvim-navic").get_location() end,
            cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
          },
        },
        lualine_x = {
          { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = fg("Special") },
          -- lsp_progress,
          {
            "diff",
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
          },
        },
        lualine_y = {
          { "progress", separator = "" },
        },
        lualine_z = {
          { "location", fmt = function(str) return "" .. str end },
        },
      },
      extensions = { "neo-tree" },
    }
  end,
}
