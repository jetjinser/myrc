vim.cmd [[packadd packer.nvim]]

return require('packer').startup({
    function(use)
        use 'wbthomason/packer.nvim'

        -- theme {{{
        use {
            {
                'projekt0n/github-nvim-theme',
                opt = true,
                config = function()
                    require('github-theme').setup()
                end
            },
            {
                'bluz71/vim-nightfly-guicolors',
                config = function()
                    vim.cmd [[colorscheme nightfly]]
                end
            },
            {
                'ajmwagar/vim-deus',
                opt = true,
                config = function()
                    vim.cmd [[colorscheme deus]]
                end
            }
        }
        -- }}}

        -- statusline TODO to be replace {{{
        use {
            'nvim-lualine/lualine.nvim',
            requires = {'kyazdani42/nvim-web-devicons', opt = true},
            config = [[ require('statusline.evil_lualine') ]]
            -- config = function()
            --     require('lualine').setup {
            --         options = {
            --             theme = 'nightfly'
            --         }
            --     }
            -- end
        }

        use {
            'kdheepak/tabline.nvim',
            config = function()
                require('tabline').setup {
                    options = {
                        show_filename_only = true,
                    }
                }
                vim.cmd[[
                set guioptions-=e
                set sessionoptions+=tabpages,globals
                ]]
            end,
            requires = { { 'hoob3rt/lualine.nvim', opt=true }, {'kyazdani42/nvim-web-devicons', opt = true} }
        }
        --- }}}

        -- start view
        use "mhinz/vim-startify"

        -- use {
        --     "Olical/aniseed",
        --     config = function() vim.cmd [[let g:aniseed#env = v:true]] end
        -- }

        -- Highlights
        use {
            'nvim-treesitter/nvim-treesitter',
            requires = {
                'nvim-treesitter/nvim-treesitter-refactor',
                'nvim-treesitter/nvim-treesitter-textobjects',
            },
            run = ':TSUpdate',
        }
        use "romgrk/nvim-treesitter-context"
        use "p00f/nvim-ts-rainbow"
        use {
            "SmiteshP/nvim-gps",
            requires = "nvim-treesitter/nvim-treesitter"
        }


        -- Quickfix
        use "kevinhwang91/nvim-bqf"

        -- search {{{
        use 'junegunn/fzf'
        use 'junegunn/fzf.vim'
        use 'kristijanhusak/vim-carbon-now-sh'
        use {
            'ggandor/lightspeed.nvim',
            keys = {
                '<Plug>Lightspeed_s',
                '<Plug>Lightspeed_S',
                '<Plug>Lightspeed_x',
                '<Plug>Lightspeed_X',
                '<Plug>Lightspeed_f',
                '<Plug>Lightspeed_F',
                '<Plug>Lightspeed_t',
                '<Plug>Lightspeed_T',
            },
            setup = function()
                local default_keymaps = {
                    { 'n', 's', '<Plug>Lightspeed_s' },
                    { 'n', 'S', '<Plug>Lightspeed_S' },
                    { 'x', 's', '<Plug>Lightspeed_s' },
                    { 'x', 'S', '<Plug>Lightspeed_S' },
                    { 'o', 'z', '<Plug>Lightspeed_s' },
                    { 'o', 'Z', '<Plug>Lightspeed_S' },
                    { 'o', 'x', '<Plug>Lightspeed_x' },
                    { 'o', 'X', '<Plug>Lightspeed_X' },
                    { 'n', 'f', '<Plug>Lightspeed_f' },
                    { 'n', 'F', '<Plug>Lightspeed_F' },
                    { 'x', 'f', '<Plug>Lightspeed_f' },
                    { 'x', 'F', '<Plug>Lightspeed_F' },
                    { 'o', 'f', '<Plug>Lightspeed_f' },
                    { 'o', 'F', '<Plug>Lightspeed_F' },
                    { 'n', 't', '<Plug>Lightspeed_t' },
                    { 'n', 'T', '<Plug>Lightspeed_T' },
                    { 'x', 't', '<Plug>Lightspeed_t' },
                    { 'x', 'T', '<Plug>Lightspeed_T' },
                    { 'o', 't', '<Plug>Lightspeed_t' },
                    { 'o', 'T', '<Plug>Lightspeed_T' },
                }
                for _, m in ipairs(default_keymaps) do
                    vim.api.nvim_set_keymap(m[1], m[2], m[3], { silent = true })
                end
            end,
        }
        -- }}}

        -- cmp
        use "williamboman/nvim-lsp-installer"
        use "neovim/nvim-lspconfig"
        use "hrsh7th/nvim-cmp"
        use "hrsh7th/cmp-nvim-lsp"
        use "hrsh7th/cmp-nvim-lua"
        use "hrsh7th/cmp-buffer"
        use "hrsh7th/cmp-emoji"
        use "hrsh7th/cmp-path"
        use "hrsh7th/cmp-calc"
        use "L3MON4D3/LuaSnip"
        use "saadparwaiz1/cmp_luasnip"
        use "kdheepak/cmp-latex-symbols"
        use { "octaltree/cmp-look", opt = true }
        use {
            'Saecki/crates.nvim',
            event = { "BufRead Cargo.toml" },
            requires = { { 'nvim-lua/plenary.nvim' } },
            config = function()
                require('crates').setup()
            end,
        }
        use "windwp/nvim-autopairs"
        use "rafamadriz/friendly-snippets"
        use { "windwp/nvim-ts-autotag", ft = {"html", "tsx", "vue", "svelte", "php"}}
        -- comment
        use "JoosepAlviste/nvim-ts-context-commentstring"
        use "tpope/vim-commentary"
        -- damn
        use { "f3fora/cmp-spell", disable = true }
        use { "itchyny/vim-haskell-indent", ft = {"haskell"} }

        -- Tree
        use {
            'kyazdani42/nvim-tree.lua',
            requires = 'kyazdani42/nvim-web-devicons',
            config = function()
                require'nvim-tree'.setup{
                    update_focused_file = {
                        enable = true,
                        update_cwd = true,
                    },
                    update_cwd = true,
                }
                vim.api.nvim_set_keymap("n", "<space>e", ":NvimTreeToggle<CR>", { noremap = true })
                vim.api.nvim_set_keymap("n", "<leader>r", ":NvimTreeRefresh<CR>", { noremap = true })
                vim.api.nvim_set_keymap("n", "<leader>g", ":NvimTreeFindFile<CR>", { noremap = true })

                vim.cmd([[doautocmd NvimTree BufEnter *]])
            end,
        }
        use {
            "simrat39/symbols-outline.nvim",
            config = function()
                vim.g.symbols_outline = {
                    keymaps = {
                        hover_symbol = "<C-k>"
                    }
                }
                vim.api.nvim_set_keymap("n", "<space>s", ":SymbolsOutline<CR>", { noremap = true })
            end
        }

        use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}

        use {'andymass/vim-matchup', event = 'VimEnter'}

        use "enomsg/vim-haskellConcealPlus"

        use {
            "rcarriga/nvim-notify",
            config = {
                require("notify").setup()
            }
        }
    end,
    config = {
        git = {
            -- default_url_fromat = "https://hub.fastgit.org/%s",
            clone_timeout = 120,
        }
    }
})
