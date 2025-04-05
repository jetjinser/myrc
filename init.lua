local function bootstrap(url, ref)
    local name = url:gsub(".*/", "")
    local path = vim.fn.stdpath("data") .. "/lazy/" .. name

    if vim.fn.isdirectory(path) == 0 then
        print(name .. ": installing in data dir...")

        vim.fn.system {"git", "clone", url, path}
        if ref then
            vim.fn.system {"git", "-C", path, "checkout", ref}
        end

        vim.cmd "redraw"
        print(name .. ": finished installing")
    end

    vim.opt.runtimepath:prepend(path)
end

-- for stable version [recommended]
-- bootstrap("https://github.com/udayvir-singh/tangerine.nvim", "v2.9")
-- https://github.com/udayvir-singh/tangerine.nvim/pull/44
bootstrap("https://github.com/arutonee1/tangerine.nvim", "8361df9")
bootstrap("https://github.com/udayvir-singh/hibiscus.nvim", "v1.7")

require("tangerine").setup {
  target = vim.fn.stdpath "data" .. "/tangerine",
  -- compile files in &rtp
  rtpdirs = { "ftplugin", "lsp", },
  compiler = {
    -- disable popup showing compiled files
    verbose = false,
    -- compile every time before sourcing init.fnl
    hooks = { "oninit" }
  },
}

