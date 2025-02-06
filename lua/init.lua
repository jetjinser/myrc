require("boot_lazy")

require("config")
require("lazy").setup("plugins", {
  change_detection = {
    enabled = false,
  }
})

-- vim.lsp.set_log_level 'debug'
-- if vim.fn.has 'nvim-0.5.1' == 1 then
--   require('vim.lsp.log').set_format_func(vim.inspect)
-- end

-- require("treesitter/init")
-- require("autocmp/init")
-- require("lsp/init")
-- require("dbg/init")
