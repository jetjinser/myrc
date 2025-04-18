return {
  {
    "chentoast/marks.nvim",
    event = "BufReadPost",
    opts = {},
  },

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

  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   event = "VeryLazy",
  --   opts = {
  --     filetypes = {
  --       "css",
  --       "javascript",
  --       "typescript",
  --       "vue",
  --       "svelte",
  --     },
  --   },
  -- },

  {
    "gpanders/editorconfig.nvim",
    cond = function(_)
      return vim.fn.has("nvim-0.9") ~= 1;
    end
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
    ---@class wk.Opts
    opts = {
      preset = "modern",
      plugins = { spelling = true },
      delay = function(ctx)
        return ctx.plugin and 0 or 500
      end,
      spec = {
        mode = { "n", "v" },
        { "<leader>b",  group = "buffer" },
        { "<leader>f",  group = "file/find" },
        { "<leader>g",  group = "git" },
        { "<leader>gh", group = "hunks" },
        { "<leader>s",  group = "search" },
        { "<leader>x",  group = "diagnostics/quickfix" },
        { "[",          group = "prev" },
        { "]",          group = "next" },
        { "g",          group = "goto" },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
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
      { "<space>E", "<leader>fE", desc = "Explorer NeoTree (cwd)",      remap = true },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0) --[[@as string]])
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    opts = {
      nesting_rules = {
        ["forester"] = {
          pattern = "(.*)-0001%.tree$",
          files = { "%1-*.tree" },
        },
      },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = {
          enabled = true,
        },
      },
      window = {
        mappings = {
          ["o"] = "toggle_node",

          ["oc"] = "noop",
          ["od"] = "noop",
          ["og"] = "noop",
          ["om"] = "noop",
          ["on"] = "noop",
          ["os"] = "noop",
          ["ot"] = "noop",
        },
      },
    },
  },

  -- todo comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble" },
    event = "BufReadPost",
    opts = {
      keywords = {
        HACK = { icon = " ", color = "hacking" },
        SAFETY = {
          icon = "󰩐 ",
          color = "hint",
          alt = { "SAFE" },
        },
      },
      colors = {
        hacking = { "DiagnosticOk", "#b3f6c0" },
      },
    },
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
    },
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
      { "zR", function() require("ufo").openAllFolds() end,  desc = "Open all folds (ufo)" },
      { "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds (ufo)" },
    },
  },

  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },

  {
    "nvim-neorg/neorg",
    ft = { "alpha", "neorg", "norg" },
    dependencies = { "luarocks.nvim" },
    version = "*",
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.summary"] = {},
        ["core.concealer"] = {
          config = {
            icons = {
              todo = {
                urgent = { icon = "" },
              },
            },
            icon_preset = "diamond";
          },
        },
        ["core.dirman"] = {
          config = {
            workspaces = {
              tech = "~/vie/writing/notes/tech",
              random = "~/vie/writing/notes/random",
              tasks = "~/vie/writing/notes/tasks",
            },
          },
        },
        ["core.completion"] = {
          config = { engine = "nvim-cmp" }
        },
        ["core.esupports.metagen"] = {
          config = {
            template = {
              { "title",       function() return vim.fn.expand "%:t:r" end },
              { "description", "" },
              { "author",      "Jinser Kafka" },
              { "categories",  "" },
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
              start = "---",
              ["end"] = "---",
            },
          },
        },
      },
    }
  },
}
