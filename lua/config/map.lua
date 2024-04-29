vim.cmd [[
  cnoreabbrev <expr> w getcmdtype() == ":" && getcmdline() =~ "^w$" ? "up" : "w"
  cnoreabbrev W w
]]

local function close_all_chan()
  for _, ui in pairs(vim.api.nvim_list_uis()) do
    if ui.chan and not ui.stdout_tty then
      vim.fn.chanclose(ui.chan)
    end
  end
end

vim.keymap.set("n", "<leader>q", close_all_chan, { noremap = true })

vim.g.mapleader = ','
vim.g.maplocalleader = ',,'
