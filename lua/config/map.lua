local function nnoremap(lhs, rhs)
  vim.keymap.set("n", lhs, rhs, { noremap = true })
end

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

nnoremap("<leader>q", close_all_chan)

vim.g.mapleader = ','
vim.g.maplocalleader = ',,'

nnoremap("]q", "<cmd>cnext<CR>")
nnoremap("[q", "<cmd>cprev<CR>")
nnoremap("<leader>co", "<cmd>copen<CR>")
nnoremap("<leader>cc", "<cmd>cclose<CR>")
