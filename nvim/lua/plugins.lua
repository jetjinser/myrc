-- vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
    -- prelude {{{
    -- self
    use("wbthomason/packer.nvim")

    -- tree-sitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    }

    -- deps
    use("nvim-lua/plenary.nvim")

    -- }}}

    -- wakatime {{{
    use "wakatime/vim-wakatime"
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
            -- vim.cmd("colorscheme nightfly")
        end,
        opt = true,
    }
    use {
        "rose-pine/neovim",
        as = "rose-pine",
        tag = "1.*",
        config = function()
            vim.o.background = "dark"
            require("rose-pine").setup {
                dark_variant = "moon",
                highlight_groups = {
                    ColorColumn = { bg = "rose" }
                }
            }
            vim.cmd("colorscheme rose-pine")
        end,
    }
    -- }}}

    -- bufferline {{{
    use {
        "akinsho/bufferline.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            vim.opt.termguicolors = true

            vim.cmd [[
                    nnoremap <silent>]b :BufferLineCycleNext<CR>
                    nnoremap <silent>[b :BufferLineCyclePrev<CR>

                    nnoremap <silent>}b :BufferLineMoveNext<CR>
                    nnoremap <silent>{b :BufferLineMovePrev<CR>

                    nnoremap <silent><leader>be :BufferLineSortByExtension<CR>
                    nnoremap <silent><leader>bd :BufferLineSortByDirectory<CR>
                ]]

            require("bufferline").setup {
                options = {
                    diagnostics = "nvim_lsp"
                }
            }
        end
    }
    -- }}}

    -- statusline {{{
    use {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons" },
        config = function()
            require('lualine').setup {
                options = { theme = "rose-pine" }
            }
        end
    }
    -- }}}

    -- tree {{{
    use {
        "kyazdani42/nvim-tree.lua",
        requires = {
            "kyazdani42/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup {
                diagnostics = {
                    enable = true,
                },
                update_cwd = true,
                reload_on_bufenter = true,
            }

            -- set shell & mapping
            vim.cmd [[
                    set shell=/bin/bash
                    " set shellcmdflag=--noprofile\ --norc\ -c

                    nnoremap <Space>e :NvimTreeToggle<CR>
                    nnoremap <Space>r :NvimTreeRefresh<CR>
                    nnoremap <Space>n :NvimTreeFindFile<CR>
                ]]
        end
    }
    -- }}}

    -- pretty vim.ui {{{
    -- use("stevearc/dressing.nvim")
    -- }}}

    -- fancy vim.notify {{{
    -- use {
    --     "rcarriga/nvim-notify",
    --     config = function()
    --         local notify = require("notify")

    --         notify.setup {
    --             stages = "slide",
    --             timeout = 4000,
    --         }

    --         vim.notify = notify
    --     end
    -- }
    -- }}}

    -- better quickfix {{{
    use "kevinhwang91/nvim-bqf"
    -- }}}

    -- indent {{{
    use {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            vim.opt.list = true

            vim.g.indent_blankline_filetype_exclude = { "man" }
            vim.g.indent_blankline_buftype_exclude = { "nofile" }

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

            vim.keymap.set("n", "]t", function()
                require("todo-comments").jump_next()
            end, { desc = "Next todo comment" })

            vim.keymap.set("n", "[t", function()
                require("todo-comments").jump_prev()
            end, { desc = "Previous todo comment" })
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
            require("specs").setup {
                show_jumps       = true,
                min_jump         = 30,
                popup            = {
                    delay_ms = 0, -- delay before popup displays
                    inc_ms = 10, -- time increments used for fade/resize effects
                    blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
                    width = 10,
                    winhl = "PMenu",
                    fader = require("specs").linear_fader,
                    resizer = require("specs").shrink_resizer
                },
                ignore_filetypes = {},
                ignore_buftypes  = {
                    nofile = true,
                },
            }
            -- Press <C-b> to call specs!
            vim.api.nvim_set_keymap("n", "<C-b>", ":lua require('specs').show_specs()<CR>",
                { noremap = true, silent = true })

            -- You can even bind it to search jumping and more, example:
            vim.api.nvim_set_keymap("n", "n", "n:lua require('specs').show_specs()<CR>",
                { noremap = true, silent = true })
            vim.api.nvim_set_keymap("n", "N", "N:lua require('specs').show_specs()<CR>",
                { noremap = true, silent = true })
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

    -- depend on tree-sitter {{{
    use {
        "nvim-treesitter/nvim-treesitter-refactor",
        requires = "nvim-treesitter/nvim-treesitter",
        config = function()
            vim.go.updatetime = 1800
            vim.cmd [[highlight link TSDefinition WildMenu]]
        end
    }

    use {
        "nvim-treesitter/nvim-treesitter-textobjects",
        requires = "nvim-treesitter/nvim-treesitter",
    }

    use {
        "p00f/nvim-ts-rainbow",
        requires = "nvim-treesitter/nvim-treesitter",
    }

    use {
        "nvim-treesitter/playground",
        opt = true,
    }

    -- neorg {{{
    use {
        "nvim-neorg/neorg",
        ft = "norg",
        after = "nvim-treesitter",
        config = function()
            require("neorg").setup {
                load = {
                    ["core.defaults"] = {},
                    ["core.norg.dirman"] = {
                        config = {
                            workspaces = {
                                work = "~/life/notes/work",
                                home = "~/life/notes/home",
                            }
                        }
                    },
                    ["core.norg.concealer"] = {},
                    -- ["core.norg.completion"] = {
                    --     config = {
                    --         engine = "nvim-cmp",
                    --     },
                    -- },
                    ["core.keybinds"] = {
                        config = {
                            default_keybinds = true,
                        }
                    },
                }
            }
        end,
        requires = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" }
    }
    -- }}}

    -- }}}

    -- lsp {{{
    use("neovim/nvim-lspconfig")
    use("jose-elias-alvarez/null-ls.nvim")
    use {
        "glepnir/lspsaga.nvim",
        config = function()
            require("lspsaga").init_lsp_saga()
        end
    }
    -- }}}

    -- cmp {{{
    use {
        "hrsh7th/nvim-cmp",
        -- branch = "dev",
    }

    use {
        "eraserhd/parinfer-rust",
        cmd = "PaiinferOn",
        run = "cargo build --release",
        ft = {
            "scheme",
        },
    }

    -- snippets
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")

    -- cmp sources
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-nvim-lua")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-emoji")
    use {
        "Saecki/crates.nvim",
        event = "BufRead Cargo.toml",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("crates").setup()
        end,
    }
    -- use("Ninlives/cmp-rime")
    use("kdheepak/cmp-latex-symbols")
    use("dmitmel/cmp-digraphs")

    -- 有机会再看看？
    -- use("machakann/vim-sandwich")

    use {
        "windwp/nvim-autopairs",
    }
    use("rafamadriz/friendly-snippets")
    -- use({ "windwp/nvim-ts-autotag", ft = { "html", "tsx", "vue", "svelte", "php" } })

    -- TODO:conceal not there
    -- use({ "itchyny/vim-haskell-indent", ft = { "haskell" } })

    -- }}}

    -- comments {{{
    use("JoosepAlviste/nvim-ts-context-commentstring")
    use("tpope/vim-commentary")
    -- }}}

    -- debugger {{{

    use "mfussenegger/nvim-dap"
    use "simrat39/rust-tools.nvim"
    use {
        "rcarriga/nvim-dap-ui",
        requires = { "mfussenegger/nvim-dap" },
        config = function()
            require("dapui").setup()
        end
    }

    -- }}}

    -- git {{{
    use {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end
    }
    -- }}}

end)
