vim.cmd [[
  cnoreabbrev <expr> w getcmdtype() == ":" && getcmdline() =~ "^w$" ? "up" : "w"
  cnoreabbrev W w
]]
