local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")

local npairs = require("nvim-autopairs")

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local utils = require('nvim-autopairs.utils')
local cmp = require('cmp')
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done({
        filetypes = {
            haskell = {
                ["("] = {
                    kind = {
                        cmp.lsp.CompletionItemKind.Function,
                        cmp.lsp.CompletionItemKind.Method
                    },
                    handler = function(char, item, bufnr, commit_character)
                        local line = utils.text_get_current_line(bufnr)
                        local _, col = utils.get_cursor()
                        local char_before, char_after = utils.text_cusor_line(line, col, 1, 1, false)

                        if char == '' or char_before == char or char_after == char
                            or (item.data and item.data.funcParensDisabled)
                            or (item.textEdit and item.textEdit.newText and item.textEdit.newText:match "[%(%[%$]")
                            or (item.insertText and item.insertText:match "[%(%[%$]")
                            or char == commit_character
                        then
                            return
                        end

                        utils.feed("<Space>")
                    end
                }
            }
        }
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

npairs.add_rules({
    Rule("|", "|", "rust")
        :with_pair(cond.before_text("("))
        :with_cr(cond.none())
})
