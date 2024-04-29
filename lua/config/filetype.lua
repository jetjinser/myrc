local fts = {
  {
    pattern = {
      [".*/conjure%-log%-%d+%.(%a+)"] = function(_path, _bufnr, ext)
        if ext == "rkt" then
          return "conjure-rkt"
        elseif ext == "py" then
          return "conjure-py"
        end
      end
    }
  },
  { extension = { ua = "uiua" } },
  { extension = { ncl = "nickel" } },
  { extension = { mdx = "markdown" } },
  { extension = { tree = "tree" } },
}

for _, ft in ipairs(fts) do
  vim.filetype.add(ft)
end
