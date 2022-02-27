vim.cmd([[packadd packer.nvim]])

return require("packer").startup({
    function(use)
        -- prelude {{{
        -- self
        use("wbthomason/packer.nvim")

        -- tree-sitter
        use {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate"
        }
        
        -- deps
        use("nvim-lua/plenary.nvim")

        -- }}}

        -- dashboard {{{
        use {
            "goolord/alpha-nvim",
            config = function()
                require("alpha").setup(require("alpha.themes.dashboard").config)
                vim.cmd([[
                    autocmd FileType alpha setlocal nofoldenable
                ]])
            end
        }
        -- }}}

        -- theme {{{
        use {
            "bluz71/vim-nightfly-guicolors",
            config = function()
                vim.cmd([[colorscheme nightfly]])
            end,
        }
        -- }}}

        -- indent {{{
        use {
            "lukas-reineke/indent-blankline.nvim",
            config = function()
                vim.opt.list = true
                -- vim.g.indentLine_char = "⎢"

                require("indent_blankline").setup {
                    show_current_context = true,
                    show_current_context_start = true,
                }
            end
        }
        -- }}}

        -- highlight todo {{{
        use {
            "folke/todo-comments.nvim",
            requires = "nvim-lua/plenary.nvim",
            config = function()
                require("todo-comments").setup()
            end
        }
        -- }}}

        -- trouble {{{
        use {
            "folke/trouble.nvim",
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
                require("trouble").setup()
            end
        }
        -- }}}

        -- terminal {{{
        use {
            "akinsho/toggleterm.nvim",
            opt = true,
        }
        -- }}}

        -- move {{{
        use {
            "edluffy/specs.nvim",
            config = function()
                require('specs').setup{ 
                    show_jumps  = true,
                    min_jump = 30,
                    popup = {
                        delay_ms = 0, -- delay before popup displays
                        inc_ms = 10, -- time increments used for fade/resize effects 
                        blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
                        width = 10,
                        winhl = "PMenu",
                        fader = require('specs').linear_fader,
                        resizer = require('specs').shrink_resizer
                    },
                    ignore_filetypes = {},
                    ignore_buftypes = {
                        nofile = true,
                    },
                }
                -- Press <C-b> to call specs!
                vim.api.nvim_set_keymap('n', '<C-b>', ':lua require("specs").show_specs()<CR>', { noremap = true, silent = true })

                -- You can even bind it to search jumping and more, example:
                vim.api.nvim_set_keymap('n', 'n', 'n:lua require("specs").show_specs()<CR>', { noremap = true, silent = true })
                vim.api.nvim_set_keymap('n', 'N', 'N:lua require("specs").show_specs()<CR>', { noremap = true, silent = true })
            end
        }
        -- }}}

        -- which-key {{{
        use {
          "folke/which-key.nvim",
          config = function()
            require("which-key").setup()
          end
        }
        -- }}}
    end
})
