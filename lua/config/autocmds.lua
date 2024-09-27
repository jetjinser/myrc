-- uiua format on save
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*.ua',
  callback = function(_)
    vim.cmd(([[
        silent! !uiua fmt %s
        mkview
        e
        loadview
    ]]):format(vim.fn.expand('<amatch>')))
  end,
})

-- QuickFix
local function quickfix_mapping()
  local function map(lhs, rhs)
    vim.keymap.set("n", lhs, rhs, { noremap = true, buffer = true, })
  end
  -- Go to the previous location and stay in the quickfix window
  map("<C-j>", "<cmd>cnext<CR>zz<C-w>w")
  -- Go to the next location and stay in the quickfix window
  map("<C-k>", "<cmd>cprev<CR>zz<C-w>w")
  -- Go to the current location and stay in the quickfix window
  map("<tab>", "<CR>zz<C-w>w")
  -- Make the quickfix list modifiable
  map("<leader>u", function()
    vim.bo.modifiable = true;
  end)
  -- Save the changes in the quickfix window
  map("<leader>w", function()
    vim.cmd [[
      cgetbuffer
      cclose
      copen
    ]]
  end)
end

vim.api.nvim_create_augroup("QuickFix", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    -- vim.opt_local.errorformat:append { [[%f|%l col %c|%m]] }
    vim.cmd [[
      setlocal errorformat+=%f\|%l\ col\ %c\|%m
    ]]
    quickfix_mapping()
  end,
  group = "QuickFix",
})
