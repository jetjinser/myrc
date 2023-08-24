require("boot_lazy")

require("config")
require("lazy").setup("plugins", {
  change_detection = {
    enabled = false,
  }
})

-- require("treesitter/init")
-- require("autocmp/init")
-- require("lsp/init")
-- require("dbg/init")
