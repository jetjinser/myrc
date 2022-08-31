local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")

local npairs = require("nvim-autopairs")

local cmp = require("cmp")

-- local ncc = require("nvim-autopairs.completion.cmp")
-- cmp.event:on('confirm_done', ncc.on_confirm_done({ map_char = { tex = '', haskell = '' } }))

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
