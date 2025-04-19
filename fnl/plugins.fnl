(local Event (require :lazy.core.handler.event))

;; add `LazyFile` event
(local lazy_file_events [:BufReadPost :BufNewFile :BufWritePre])
(set Event.mappings.LazyFile {:event lazy_file_events :id :LazyFile})
(tset Event.mappings "User LazyFile" Event.mappings.LazyFile)

(local lang-in-repl [:clojure :fennel :scheme])

[;; fennel transpiler & library
 {1 :arutonee1/tangerine.nvim :lazy false}
 {1 :udayvir-singh/hibiscus.nvim :lazy false}

 ;; plugin manager
 {1 :folke/lazy.nvim :lazy false}

 ;; colorscheme
 {1 :rose-pine/neovim :priority 1000 :lazy false
    :init #(vim.cmd.colorscheme :rose-pine)}

 ;; treesitter
 {1 :nvim-treesitter/nvim-treesitter
    :build ":TSUpdate"
    :event [:LazyFile :VeryLazy]
    :cmd [:TSUpdateSync :TSUpdate :TSInstall]
    :opts {:highlight {:enable true}
           :indent {:enable true}
           :ensure_installed [:fennel
                              :nix
                              :rust]}
    :lazy (= (vim.fn.argc (- 1)) 0)
    :config (λ [_ opts]
               ((. (require :nvim-treesitter.configs) :setup) opts))}

 {1 :Olical/conjure
    :ft lang-in-repl
    :init (fn []
            (set vim.g.conjure#mapping#prefix ",,")
            ;; <localleader>k
            (set vim.g.conjure#mapping#doc_word "k"))}
 {1 :gpanders/nvim-parinfer
    :ft lang-in-repl}

 (let [nowait-cmd (fn [cmd] {1 cmd :nowait false})]
   {1 :nvim-neo-tree/neo-tree.nvim
    :branch "v3.x"
    :cmd "Neotree"
    :keys (let [execute #((. (require :neo-tree.command) :execute) $1)]
            [{1 "<leader>e" 2 #(execute { :toggle true :dir (vim.uv.cwd)})}])
    :dependencies [:nvim-lua/plenary.nvim
                   :nvim-tree/nvim-web-devicons
                   :MunifTanjim/nui.nvim
                   {1 :s1n7ax/nvim-window-picker
                      :version "2.*"
                      :config true}]
    :opts {:filesystem {:window {:mappings {:O  {1 :show_help :nowait false
                                                   :config {:title "Order by" :prefix_key "O"}}
                                            :Oc (nowait-cmd :order_by_created)
                                            :Od (nowait-cmd :order_by_diagnostics)
                                            :Og (nowait-cmd :order_by_git_status)
                                            :Om (nowait-cmd :order_by_modified)
                                            :On (nowait-cmd :order_by_name)
                                            :Os (nowait-cmd :order_by_size)
                                            :Ot (nowait-cmd :order_by_type)
                                            :o :toggle_node :oc false :od false :og false
                                            :om false :on false :os false :ot false}}}}})]

