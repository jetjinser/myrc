vim.filetype.add {
  pattern = {
    [".*/conjure%-log%-%d+%.(%a+)"] = function(_path, _bufnr, ext)
      if ext == "rkt" then
        return "conjure-rkt"
      elseif ext == "py" then
        return "conjure-py"
      end
    end
  },
}

vim.filetype.add({ extension = { ua = "uiua" } })
vim.filetype.add({ extension = { ncl = "nickel" } })
vim.filetype.add({ extension = { mdx = "markdown" } })
