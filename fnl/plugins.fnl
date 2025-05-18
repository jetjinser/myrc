;; https://github.com/bakpakin/Fennel/issues/353#issuecomment-2604946507
(macro tx [& args]
  "Mixed sequential and associative tables at compile time"
  (let [to-merge (when (table? (. args (length args)))
                   (table.remove args))]
    (if to-merge
        (do (each [key value (pairs to-merge)]
             (tset args key value))
            args)
        args)))

(local Event (require :lazy.core.handler.event))

;; add `LazyFile` event
(local lazy_file_events [:BufReadPost :BufNewFile :BufWritePre])
(set Event.mappings.LazyFile {:event lazy_file_events :id :LazyFile})
(tset Event.mappings "User LazyFile" Event.mappings.LazyFile)

(local lang-in-repl [:clojure :fennel :scheme :lisp])

[;; fennel transpiler & library
 (tx :arutonee1/tangerine.nvim {:lazy false})
 (tx :udayvir-singh/hibiscus.nvim {:lazy false})

 ;; plugin manager
 (tx :folke/lazy.nvim {:lazy false})

 ;; colorscheme
 (tx :rose-pine/neovim
     {:priority 1000 :lazy false :init #(vim.cmd.colorscheme :rose-pine)})

 ;; treesitter
 (tx :nvim-treesitter/nvim-treesitter
     {:build ":TSUpdate"
      :event [:LazyFile :VeryLazy]
      :cmd [:TSUpdateSync :TSUpdate :TSInstall]
      :opts {:highlight {:enable true}
             :indent    {:enable true}
             :ensure_installed [:fennel
                                :nix
                                :rust
                                :scheme]}
      :lazy (= (vim.fn.argc (- 1)) 0)
      :config (λ [_ opts]
                ((. (require :nvim-treesitter.configs) :setup) opts))})

 ;; repl
 (tx :Olical/conjure
     {:ft lang-in-repl
      :init (fn []
              (set vim.g.conjure#mapping#prefix ",,")
              ;; <localleader>k
              (set vim.g.conjure#mapping#doc_word :k)
              (set vim.g.conjure#filetype#scheme "conjure.client.guile.socket")
              (set vim.g.conjure#client#guile#socket#pipename ".guile-repl.socket"))})

 ;; sexp
 (tx :gpanders/nvim-parinfer {:ft lang-in-repl})

 ;; file-like tree
 (let [nowait-cmd (fn [cmd] {1 cmd :nowait false})
       mappings {:O {1 :show_help :nowait false
                     :config {:title "Order by" :prefix_key :O}}
                 :Oc (nowait-cmd :order_by_created)
                 :Od (nowait-cmd :order_by_diagnostics)
                 :Og (nowait-cmd :order_by_git_status)
                 :Om (nowait-cmd :order_by_modified)
                 :On (nowait-cmd :order_by_name)
                 :Os (nowait-cmd :order_by_size)
                 :Ot (nowait-cmd :order_by_type)
                 :o :toggle_node :oc false :od false :og false
                 :om false       :on false :os false :ot false}]
   (tx :nvim-neo-tree/neo-tree.nvim
       {:branch :v3.x
        :cmd :Neotree
        :keys (let [execute #((. (require :neo-tree.command) :execute) $1)]
                [[:<leader>e #(execute {:toggle true :dir (vim.uv.cwd)})]])
        :dependencies [:nvim-lua/plenary.nvim
                       :nvim-tree/nvim-web-devicons
                       :MunifTanjim/nui.nvim
                       (tx :s1n7ax/nvim-window-picker
                           {:version :2.* :config true})]
        :opts {:filesystem {:window {: mappings}
                            :bind_to_cwd :false
                            :follow_current_file {:enabled :true}}}}))
 ;; git
 (let [on_attach
       (fn [buffer]
         (let [gs (require :gitsigns)
               map (fn [mode l r desc]
                     (vim.keymap.set mode l r {: buffer : desc}))
               vline #[(vim.fn.line ".") (vim.fn.line :v)]]
           ; Navigation
           (map :n       "]h"          #(gs.nav_hunk :next)          "Next Hunk")
           (map :n       "[h"          #(gs.nav_hunk :prev)          "Prev Hunk")
           (map :n       "]H"          #(gs.nav_hunk :last)          "Last Hunk")
           (map :n       "[H"          #(gs.nav_hunk :first)         "First Hunk")
           ;; Actions
           (map :n       "<leader>ghs" gs.stage_hunk                 "Stage Hunk")
           (map :v       "<leader>ghs" #(gs.stage_hunk (vline))      "Stage Selected Hunk")
           (map :n       "<leader>ghr" gs.reset_hunk                 "Reset Hunk")
           (map :v       "<leader>ghr" #(gs.reset_hunk (vline))      "Reset Selected Hunk")
           (map :n       "<leader>ghS" gs.stage_buffer               "Stage Buffer")
           (map :n       "<leader>ghR" gs.reset_buffer               "Reset Buffer")
           (map :n       "<leader>ghp" gs.preview_hunk               "Preview Hunk")
           (map :n       "<leader>ghi" gs.preview_hunk_inline        "Preview Hunk Inline")
           (map :n       "<leader>ghb" #(gs.blame_line {:full true}) "Blame Line")
           (map :n       "<leader>ghd" gs.diffthis                   "Diff This")
           (map :n       "<leader>ghD" #(gs.diffthis "~")            "Diff This ~")
           (map :n       "<leader>ghq" gs.setqflist                  "Set QuickFix List")
           (map :n       "<leader>ghQ" #(gs.setqflist :all)          "Set All QuickFix List")
           ;; Toggles
           (map :n       "<leader>gtb" gs.toggle_current_line_blame  "Toggle Current Line Blame")
           (map :n       "<leader>gtd" gs.toggle_deleted             "Toggle Deleted")
           (map :n       "<leader>gtw" gs.toggle_word_diff           "Toggle Word Diff")
           ;; Text object
           (map [:o :x] "ih"           gs.select_hunk                "Select Hunk")))]
   (tx :lewis6991/gitsigns.nvim {:event :LazyFile :opts {: on_attach}}))

 ;; quick jump
 (let [flash #((. (require :flash) $1))
       key (fn [mode lhs rhs desc] {1 lhs 2 rhs : mode : desc})]
   (tx :folke/flash.nvim
       {:event :VeryLazy
        :keys [(key [   :n :o :x] "s"     #(flash :jump)              "Flash")
               (key [   :n :o :x] "S"     #(flash :treesitter)        "Flash Treesitter")
               (key [      :o   ] "r"     #(flash :remote)            "Remote Flash")
               (key [      :o :x] "R"     #(flash :treesitter_search) "Treesitter Search")
               (key [:c         ] "<C-s>" #(flash :toggle)            "Toggle Flash Search")]
        :opts {}}))

 ;; which key
 (let [wk #(. (require :which-key) $1)
       group (fn [cmd group] (tx cmd {: group}))]
   (tx :folke/which-key.nvim
       {:enabled false ;; breaks <C-o>
        :event :VeryLazy
        :opts_extend [:spec]
        :opts {:spec (tx (group "<leader>g"  :git)
                         (group "<leader>gh" :hunks)
                         (group "<leader>s"  :search)
                         (group "["          :prev)
                         (group "]"          :next)
                         (group "g"          :goto)
                         {:mode [:n :v]})
               :delay (fn [ctx] (or (and ctx.plugin 0) 300))}
        :keys [(tx "<leader>?" #((wk :show) {:global false})
                   {:desc "Buffer Keymaps (which-key)"})
               (tx "<c-w><space>" #((wk :show) {:keys :<c-w> :loop true})
                   {:desc "Window Hydra Mode (which-key)"})]}))

 ;; cmp
 (tx :saghen/blink.cmp
     {:version "1.*"
      :event :InsertEnter
      :build "nix run .#build-plugin"
      :keymap {:preset :super-tab
               :<C-space> [:select_and_accept]}
      :completion {:documentation {:auto_show true}}
      :opts {}
      :opts_extend ["sources.default"]})

 ;; language tools
 (tx :moonbit-community/moonbit.nvim
     {:ft [:moonbit]
      :opts {:treesitter {:enabled true}
             :lsp {}}})

 ;; signature
 (tx :chentoast/marks.nvim
     {:event :VeryLazy
      :opts {}})

 ;; statics
 (tx :wakatime/vim-wakatime {:event :LazyFile})]

