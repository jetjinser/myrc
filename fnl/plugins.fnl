(local Event (require :lazy.core.handler.event))

;; add `LazyFile` event
(local lazy_file_events [:BufReadPost :BufNewFile :BufWritePre])
(set Event.mappings.LazyFile {:event lazy_file_events :id :LazyFile})
(tset Event.mappings "User LazyFile" Event.mappings.LazyFile)

[
 ;; fennel transpiler & library
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
           :ensure_installed [ :fennel
                               :rust
                             ]}
    :lazy (= (vim.fn.argc (- 1)) 0)
    :config (λ [_ opts]
               ((. (require :nvim-treesitter.configs) :setup) opts))}
]
