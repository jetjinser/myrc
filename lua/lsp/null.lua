local null_ls = require("null-ls")

local sources = {
    null_ls.builtins.code_actions.statix,

    null_ls.builtins.diagnostics.chktex,
    null_ls.builtins.diagnostics.deadnix,
    null_ls.builtins.diagnostics.gitlint,
    null_ls.builtins.diagnostics.markdownlint,

    null_ls.builtins.formatting.alejandra,
    null_ls.builtins.formatting.latexindent,
    null_ls.builtins.formatting.markdownlint,
    null_ls.builtins.formatting.taplo,
}

null_ls.setup { sources = sources }
