-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/jinserlin/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/jinserlin/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/jinserlin/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/jinserlin/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/jinserlin/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  LuaSnip = {
    loaded = true,
    path = "/Users/jinserlin/.local/share/nvim/site/pack/packer/start/LuaSnip"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/jinserlin/.local/share/nvim/site/pack/packer/start/cmp-buffer"
  },
  ["cmp-emoji"] = {
    loaded = true,
    path = "/Users/jinserlin/.local/share/nvim/site/pack/packer/start/cmp-emoji"
  },
  ["cmp-latex-symbols"] = {
    loaded = true,
    path = "/Users/jinserlin/.local/share/nvim/site/pack/packer/start/cmp-latex-symbols"
  },
  ["cmp-look"] = {
    after_files = { "/Users/jinserlin/.local/share/nvim/site/pack/packer/opt/cmp-look/after/plugin/cmp_look.lua" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jinserlin/.local/share/nvim/site/pack/packer/opt/cmp-look"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/jinserlin/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp"
  },
  ["cmp-spell"] = {
    loaded = true,
    path = "/Users/jinserlin/.local/share/nvim/site/pack/packer/start/cmp-spell"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/jinserlin/.local/share/nvim/site/pack/packer/start/cmp_luasnip"
  },
  ["crates.nvim"] = {
    after_files = { "/Users/jinserlin/.local/share/nvim/site/pack/packer/opt/crates.nvim/after/plugin/cmp_crates.lua" },
    config = { "\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\vcrates\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jinserlin/.local/share/nvim/site/pack/packer/opt/crates.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/Users/jinserlin/.local/share/nvim/site/pack/packer/start/friendly-snippets"
  },
  fzf = {
    loaded = true,
    path = "/Users/jinserlin/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/Users/jinserlin/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  ["github-nvim-theme"] = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\17github-theme\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jinserlin/.local/share/nvim/site/pack/packer/opt/github-nvim-theme"
  },
  ["lightspeed.nvim"] = {
    keys = { { "", "<Plug>Lightspeed_s" }, { "", "<Plug>Lightspeed_S" }, { "", "<Plug>Lightspeed_x" }, { "", "<Plug>Lightspeed_X" }, { "", "<Plug>Lightspeed_f" }, { "", "<Plug>Lightspeed_F" }, { "", "<Plug>Lightspeed_t" }, { "", "<Plug>Lightspeed_T" } },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jinserlin/.local/share/nvim/site/pack/packer/opt/lightspeed.nvim"
  },
  ["lualine.nvim"] = {
    config = { " require('statusline.evil_lualine') " },
    loaded = true,
    path = "/Users/jinserlin/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/Users/jinserlin/.local/share/nvim/site/pack/packer/start/nvim-autopairs"
  },
  ["nvim-bqf"] = {
    loaded = true,
    path = "/Users/jinserlin/.local/share/nvim/site/pack/packer/start/nvim-bqf"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/Users/jinserlin/.local/share/nvim/site/pack/packer/start/nvim-cmp"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/Users/jinserlin/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/jinserlin/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/jinserlin/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-context"] = {
    loaded = true,
    path = "/Users/jinserlin/.local/share/nvim/site/pack/packer/start/nvim-treesitter-context"
  },
  ["nvim-treesitter-refactor"] = {
    loaded = true,
    path = "/Users/jinserlin/.local/share/nvim/site/pack/packer/start/nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/Users/jinserlin/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/Users/jinserlin/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/jinserlin/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/jinserlin/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/jinserlin/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["tabline.nvim"] = {
    config = { "\27LJ\2\nã\1\0\0\4\0\t\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\0016\0\6\0009\0\a\0'\2\b\0B\0\2\1K\0\1\0l                set guioptions-=e\n                set sessionoptions+=tabpages,globals\n                \bcmd\bvim\foptions\1\0\0\1\0\1\23show_filename_only\2\nsetup\ftabline\frequire\0" },
    loaded = true,
    path = "/Users/jinserlin/.local/share/nvim/site/pack/packer/start/tabline.nvim"
  },
  ["vim-carbon-now-sh"] = {
    loaded = true,
    path = "/Users/jinserlin/.local/share/nvim/site/pack/packer/start/vim-carbon-now-sh"
  },
  ["vim-deus"] = {
    config = { "\27LJ\2\n4\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\21colorscheme deus\bcmd\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jinserlin/.local/share/nvim/site/pack/packer/opt/vim-deus"
  },
  ["vim-nightfly-guicolors"] = {
    config = { "\27LJ\2\n8\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\25colorscheme nightfly\bcmd\bvim\0" },
    loaded = true,
    path = "/Users/jinserlin/.local/share/nvim/site/pack/packer/start/vim-nightfly-guicolors"
  },
  ["vim-startify"] = {
    loaded = true,
    path = "/Users/jinserlin/.local/share/nvim/site/pack/packer/start/vim-startify"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: lightspeed.nvim
time([[Setup for lightspeed.nvim]], true)
try_loadstring("\27LJ\2\n­\6\0\0\f\0\25\00084\0\21\0005\1\0\0>\1\1\0005\1\1\0>\1\2\0005\1\2\0>\1\3\0005\1\3\0>\1\4\0005\1\4\0>\1\5\0005\1\5\0>\1\6\0005\1\6\0>\1\a\0005\1\a\0>\1\b\0005\1\b\0>\1\t\0005\1\t\0>\1\n\0005\1\n\0>\1\v\0005\1\v\0>\1\f\0005\1\f\0>\1\r\0005\1\r\0>\1\14\0005\1\14\0>\1\15\0005\1\15\0>\1\16\0005\1\16\0>\1\17\0005\1\17\0>\1\18\0005\1\18\0>\1\19\0005\1\19\0>\1\20\0006\1\20\0\18\3\0\0B\1\2\4X\4\b€6\6\21\0009\6\22\0069\6\23\6:\b\1\5:\t\2\5:\n\3\0055\v\24\0B\6\5\1E\4\3\3R\4öK\0\1\0\1\0\1\vsilent\2\20nvim_set_keymap\bapi\bvim\vipairs\1\4\0\0\6o\6T\23<Plug>Lightspeed_T\1\4\0\0\6o\6t\23<Plug>Lightspeed_t\1\4\0\0\6x\6T\23<Plug>Lightspeed_T\1\4\0\0\6x\6t\23<Plug>Lightspeed_t\1\4\0\0\6n\6T\23<Plug>Lightspeed_T\1\4\0\0\6n\6t\23<Plug>Lightspeed_t\1\4\0\0\6o\6F\23<Plug>Lightspeed_F\1\4\0\0\6o\6f\23<Plug>Lightspeed_f\1\4\0\0\6x\6F\23<Plug>Lightspeed_F\1\4\0\0\6x\6f\23<Plug>Lightspeed_f\1\4\0\0\6n\6F\23<Plug>Lightspeed_F\1\4\0\0\6n\6f\23<Plug>Lightspeed_f\1\4\0\0\6o\6X\23<Plug>Lightspeed_X\1\4\0\0\6o\6x\23<Plug>Lightspeed_x\1\4\0\0\6o\6Z\23<Plug>Lightspeed_S\1\4\0\0\6o\6z\23<Plug>Lightspeed_s\1\4\0\0\6x\6S\23<Plug>Lightspeed_S\1\4\0\0\6x\6s\23<Plug>Lightspeed_s\1\4\0\0\6n\6S\23<Plug>Lightspeed_S\1\4\0\0\6n\6s\23<Plug>Lightspeed_s\0", "setup", "lightspeed.nvim")
time([[Setup for lightspeed.nvim]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
 require('statusline.evil_lualine') 
time([[Config for lualine.nvim]], false)
-- Config for: tabline.nvim
time([[Config for tabline.nvim]], true)
try_loadstring("\27LJ\2\nã\1\0\0\4\0\t\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\0016\0\6\0009\0\a\0'\2\b\0B\0\2\1K\0\1\0l                set guioptions-=e\n                set sessionoptions+=tabpages,globals\n                \bcmd\bvim\foptions\1\0\0\1\0\1\23show_filename_only\2\nsetup\ftabline\frequire\0", "config", "tabline.nvim")
time([[Config for tabline.nvim]], false)
-- Config for: vim-nightfly-guicolors
time([[Config for vim-nightfly-guicolors]], true)
try_loadstring("\27LJ\2\n8\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\25colorscheme nightfly\bcmd\bvim\0", "config", "vim-nightfly-guicolors")
time([[Config for vim-nightfly-guicolors]], false)
-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[noremap <silent> <Plug>Lightspeed_s <cmd>lua require("packer.load")({'lightspeed.nvim'}, { keys = "<lt>Plug>Lightspeed_s", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>Lightspeed_T <cmd>lua require("packer.load")({'lightspeed.nvim'}, { keys = "<lt>Plug>Lightspeed_T", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>Lightspeed_t <cmd>lua require("packer.load")({'lightspeed.nvim'}, { keys = "<lt>Plug>Lightspeed_t", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>Lightspeed_F <cmd>lua require("packer.load")({'lightspeed.nvim'}, { keys = "<lt>Plug>Lightspeed_F", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>Lightspeed_f <cmd>lua require("packer.load")({'lightspeed.nvim'}, { keys = "<lt>Plug>Lightspeed_f", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>Lightspeed_X <cmd>lua require("packer.load")({'lightspeed.nvim'}, { keys = "<lt>Plug>Lightspeed_X", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>Lightspeed_S <cmd>lua require("packer.load")({'lightspeed.nvim'}, { keys = "<lt>Plug>Lightspeed_S", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>Lightspeed_x <cmd>lua require("packer.load")({'lightspeed.nvim'}, { keys = "<lt>Plug>Lightspeed_x", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufRead Cargo.toml ++once lua require("packer.load")({'crates.nvim'}, { event = "BufRead Cargo.toml" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
