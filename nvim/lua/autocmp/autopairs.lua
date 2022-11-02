local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")

local npairs = require("nvim-autopairs")

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done({
      haskell = false,
  })
)

npairs.setup {
    disable_filetype = {
        "vim",
        "scheme",
    }
}

npairs.add_rules({
    Rule("<", ">", "rust")
        :with_pair(cond.after_regex("%w"))
        :with_cr(cond.none())
})
