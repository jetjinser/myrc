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
            opt = true
        }
        -- }}}
    end
})
