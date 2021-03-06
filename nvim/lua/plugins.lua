vim.cmd([[packadd packer.nvim]])

return require("packer").startup({
	function(use)
		use("wbthomason/packer.nvim")

		-- theme {{{
		use({
			{
				"projekt0n/github-nvim-theme",
				opt = true,
				config = function()
					require("github-theme").setup()
				end,
			},
			{
				"bluz71/vim-nightfly-guicolors",
				config = function()
					vim.cmd([[colorscheme nightfly]])
				end,
			},
			{
				"ajmwagar/vim-deus",
				opt = true,
				config = function()
					vim.cmd([[colorscheme deus]])
				end,
			},
		})
		-- }}}

		use({
			"windwp/windline.nvim",
			config = function()
				require("statusline.evil_line")
			end,
			requires = {
				{
					"lewis6991/gitsigns.nvim",
					config = function()
						require("gitsigns").setup()
					end,
				},
			},
		})

		-- start view
		use("mhinz/vim-startify")

		-- use {
		--     "Olical/aniseed",
		--     config = function() vim.cmd [[let g:aniseed#env = v:true]] end
		-- }

		-- Highlights
		use({
			"nvim-treesitter/nvim-treesitter",
			requires = {
				"nvim-treesitter/nvim-treesitter-refactor",
				"nvim-treesitter/nvim-treesitter-textobjects",
			},
			run = ":TSUpdate",
		})
		use("p00f/nvim-ts-rainbow")
		use({
			"SmiteshP/nvim-gps",
			requires = "nvim-treesitter/nvim-treesitter",
			config = function()
				require("nvim-gps").setup({
					icons = {
						["function-name"] = "λ ",
						["container-name"] = "𑂼 ",
					},
				})
			end,
		})

		-- Quickfix
		use("kevinhwang91/nvim-bqf")

		-- search {{{
		use("junegunn/fzf")
		use("junegunn/fzf.vim")
		use("kristijanhusak/vim-carbon-now-sh")
		use({
			"ggandor/lightspeed.nvim",
			keys = {
				"<Plug>Lightspeed_s",
				"<Plug>Lightspeed_S",
				"<Plug>Lightspeed_x",
				"<Plug>Lightspeed_X",
				"<Plug>Lightspeed_f",
				"<Plug>Lightspeed_F",
				"<Plug>Lightspeed_t",
				"<Plug>Lightspeed_T",
			},
			setup = function()
				local default_keymaps = {
					{ "n", "s", "<Plug>Lightspeed_s" },
					{ "n", "S", "<Plug>Lightspeed_S" },
					{ "x", "s", "<Plug>Lightspeed_s" },
					{ "x", "S", "<Plug>Lightspeed_S" },
					{ "o", "z", "<Plug>Lightspeed_s" },
					{ "o", "Z", "<Plug>Lightspeed_S" },
					{ "o", "x", "<Plug>Lightspeed_x" },
					{ "o", "X", "<Plug>Lightspeed_X" },
					{ "n", "f", "<Plug>Lightspeed_f" },
					{ "n", "F", "<Plug>Lightspeed_F" },
					{ "x", "f", "<Plug>Lightspeed_f" },
					{ "x", "F", "<Plug>Lightspeed_F" },
					{ "o", "f", "<Plug>Lightspeed_f" },
					{ "o", "F", "<Plug>Lightspeed_F" },
					{ "n", "t", "<Plug>Lightspeed_t" },
					{ "n", "T", "<Plug>Lightspeed_T" },
					{ "x", "t", "<Plug>Lightspeed_t" },
					{ "x", "T", "<Plug>Lightspeed_T" },
					{ "o", "t", "<Plug>Lightspeed_t" },
					{ "o", "T", "<Plug>Lightspeed_T" },
				}
				for _, m in ipairs(default_keymaps) do
					vim.api.nvim_set_keymap(m[1], m[2], m[3], { silent = true })
				end
			end,
		})
		-- }}}

		-- cmp
		use("williamboman/nvim-lsp-installer")
		use("neovim/nvim-lspconfig")
		use("hrsh7th/nvim-cmp")
		use("hrsh7th/cmp-nvim-lsp")
		use("hrsh7th/cmp-nvim-lua")
		use("hrsh7th/cmp-buffer")
		use("hrsh7th/cmp-emoji")
		use("hrsh7th/cmp-path")
		use("hrsh7th/cmp-calc")
		use("L3MON4D3/LuaSnip")
		use("saadparwaiz1/cmp_luasnip")
		use("kdheepak/cmp-latex-symbols")
		use({ "octaltree/cmp-look", opt = true })
		use({
			"Saecki/crates.nvim",
			event = { "BufRead Cargo.toml" },
			requires = { { "nvim-lua/plenary.nvim" } },
			config = function()
				require("crates").setup()
			end,
		})
		use("windwp/nvim-autopairs")
		use("rafamadriz/friendly-snippets")
		use({ "windwp/nvim-ts-autotag", ft = { "html", "tsx", "vue", "svelte", "php" } })
		-- comment
		use("JoosepAlviste/nvim-ts-context-commentstring")
		use("tpope/vim-commentary")
		-- damn
		use({ "f3fora/cmp-spell", disable = true })
		use({ "itchyny/vim-haskell-indent", ft = { "haskell" } })

		-- Tree
		use({
			"kyazdani42/nvim-tree.lua",
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				require("nvim-tree").setup({
					update_focused_file = {
						enable = true,
						update_cwd = true,
					},
					update_cwd = true,
				})
				vim.api.nvim_set_keymap("n", "<space>e", ":NvimTreeToggle<CR>", { noremap = true })
				vim.api.nvim_set_keymap("n", "<leader>r", ":NvimTreeRefresh<CR>", { noremap = true })
				vim.api.nvim_set_keymap("n", "<leader>g", ":NvimTreeFindFile<CR>", { noremap = true })

				vim.cmd([[doautocmd NvimTree BufEnter *]])
			end,
		})
		use({
			"simrat39/symbols-outline.nvim",
			config = function()
				vim.g.symbols_outline = {
					keymaps = {
						hover_symbol = "<C-k>",
					},
				}
				vim.api.nvim_set_keymap("n", "<space>s", ":SymbolsOutline<CR>", { noremap = true })
			end,
		})

		use({ "akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons" })

		use({ "andymass/vim-matchup", event = "VimEnter" })

		use("enomsg/vim-haskellConcealPlus")

		use({
			"rcarriga/nvim-notify",
			config = {
				require("notify").setup({
					background_colour = "#000000",
				}),
			},
		})
		use("wakatime/vim-wakatime")

		use({
			"skywind3000/asynctasks.vim",
			config = function()
				vim.api.nvim_set_var("asyncrun_open", 6)
			end,
			requires = {
				"skywind3000/asyncrun.vim",
			},
		})

		use({
			"github/copilot.vim",
			opt = true,
		})

		use({
			"nvim-telescope/telescope.nvim",
			requires = { { "nvim-lua/plenary.nvim" } },
			config = function()
				vim.cmd([[
                nnoremap <leader>ff <cmd>Telescope find_files<cr>
                nnoremap <leader>fg <cmd>Telescope live_grep<cr>
                nnoremap <leader>fb <cmd>Telescope buffers<cr>
                nnoremap <leader>fh <cmd>Telescope help_tags<cr>
                ]])
			end,
		})

		use({
			"nvim-neorg/neorg",
			config = function()
				require("neorg").setup({
					-- Tell Neorg what modules to load
					load = {
						["core.defaults"] = {}, -- Load all the default modules
                        ["core.keybinds"] = {
                            config = {
                                default_keybinds = true,
                            }
                        },
						["core.norg.concealer"] = {}, -- Allows for use of icons
						["core.norg.dirman"] = { -- Manage your directories with Neorg
							config = {
								workspaces = {
									my_workspace = "~/life/neorg",
								},
							},
						},
						["core.norg.completion"] = {
							config = {
								engine = "nvim-cmp",
							},
						},
						["core.integrations.telescope"] = {}, -- Enable the telescope module
					},
				})
			end,
			requires = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" },
		})

        use {
            "gelguy/wilder.nvim",
            run = ":UpdateRemotePlugins",
        }

        use {
            "Olical/conjure",
            requires = { "wlangstroth/vim-racket" }
        }
	end,
	config = {
		git = {
			-- default_url_fromat = "https://hub.fastgit.org/%s",
			clone_timeout = 120,
		},
	},
})
