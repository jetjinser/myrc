return {
  -- easily jump to any location
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
    end,
  },
  -- 我能吞下玻璃而不伤身体

  {
    "gpanders/editorconfig.nvim",
    cond = function(_)
      return vim.fn.has("nvim-0.9") ~= 1;
    end
  },

  -- buffer remove
  {
    "echasnovski/mini.bufremove",
    keys = {
      { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
  },

  -- search/replace in multiple files
  {
    "windwp/nvim-spectre",
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },

  -- references
  {
    "RRethy/vim-illuminate",
    event = "BufReadPost",
    opts = { delay = 200 },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
    -- stylua: ignore
    keys = {
      { "]]", function() require("illuminate").goto_next_reference(false) end, desc = "Next Reference", },
      { "[[", function() require("illuminate").goto_prev_reference(false) end, desc = "Prev Reference" },
    },
  },

  -- git signs
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },

  -- which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register({
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader>f"] = { name = "+file/find" },
        ["<leader>s"] = { name = "+search" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>gh"] = { name = "+hunks" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
      })
    end,
  },

  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = {
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = require("util").get_root() })
        end,
        desc = "Explorer NeoTree (root dir)",
      },
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      { "<space>e", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
      { "<space>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0)--[[@as string]] )
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    opts = {
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = true,
      },
      window = {
        mappings = {
          ["o"] = "toggle_node",
        },
      },
    },
  },

  -- better diagnostics list and others
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
    },
  },

  -- todo comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble" },
    event = "BufReadPost",
    config = true,
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo Trouble" },
      { "<leader>xtt", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo Trouble" },
    },
  },

  -- better hlsearch
  {
    "kevinhwang91/nvim-hlslens",
    dependencies = {
      "kevinhwang91/nvim-ufo",
    },
    keys = {
      { "n", "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>",
        desc = "Lens n" },
      { "N", "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>",
        desc = "Lens N" },
      { "*", "*<Cmd>lua require('hlslens').start()<CR>", desc = "Lens *" },
      { "#", "#<Cmd>lua require('hlslens').start()<CR>", desc = "Lens #" },
      { "g*", "g*<Cmd>lua require('hlslens').start()<CR>", desc = "Lens g*" },
      { "g#", "g*<Cmd>lua require('hlslens').start()<CR>", desc = "Lens g#" },
    }
  },

  -- enhanced matchparen.vim
  {
    "utilyre/sentiment.nvim",
    version = "*",
    event = "VeryLazy",
    opts = {},
    init = function()
      vim.g.loaded_matchparen = 1
    end,
  },

  -- better fold
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async"
    },
    opts = {
      open_fold_hl_timeout = 0,
    },
    init = function()
      local o = vim.o
      o.foldcolumn = "1"
      o.foldlevel = 99
      o.foldlevelstart = 99
      o.foldenable = true
      o.foldmethod = "manual"
      o.fillchars = [[eob:~,fold: ,foldopen:,foldsep: ,foldclose:]]
    end,
    keys = {
      { "zR", function() require("ufo").openAllFolds() end, desc = "Open all folds (ufo)" },
      { "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds (ufo)" },
    },
  },

  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.summary"] = {},
        ["core.concealer"] = {
          config = {
            icons = {
              todo = {
                done = { icon = "✓" },
                pending = { icon = "▶" },
              },
            },

          },
        },
        ["core.dirman"] = {
          config = {
            workspaces = {
              tech = "~/life/notes/tech",
              random = "~/life/notes/random",
            },
          },
        },
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp"
          }
        },
        ["core.esupports.metagen"] = {
          config = {
            template = {
              { "title", function() return vim.fn.expand "%:t:r" end },
              { "description", "" },
              { "author", "Jinser Kafka" },
              { "categories", "" },
              { "created", function()
                os.setlocale("en_US.UTF-8")
                return os.date("%d %b %Y %H:%M")
              end },
              { "updated", function()
                os.setlocale("en_US.UTF-8")
                return os.date("%d %b %Y %H:%M")
              end },
              { "version", "0.0.1" },
            },
            type = "auto",
          },
        },
        ["core.export"] = {},
        ["core.export.markdown"] = {
          config = {
            extensions = {
              "mathematics",
              "metadata",
            },
            metadata = {
              start = "+++",
              ["end"] = "+++",
            },
          },
        },
      },
    }
  },
}
