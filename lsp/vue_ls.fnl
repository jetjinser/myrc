(fn get_typescript_server_path [root-dir]
  (let [project-roots (vim.fs.find :node_modules
                                   {:limit math.huge
                                    :path root-dir
                                    :upward true})]
    (each [_ project-root (ipairs project-roots)]
      (local typescript-path (.. project-root :/typescript))
      (local stat (vim.loop.fs_stat typescript-path))
      (when (and stat (= stat.type :directory))
        (let [___antifnl_rtn_1___ (.. typescript-path :/lib)]
          (lua "return ___antifnl_rtn_1___"))))
    ""))

{:cmd [:vue-language-server  :--stdio]
 :root_markers [:package.json :.git]
 :filetypes [:vue]
 :init_options {:typescript {:tsdk ""}}
 :before_init (fn [_ config]
                (when (and (and config.init_options
                                config.init_options.typescript)
                           (= config.init_options.typescript.tsdk ""))
                  (set config.init_options.typescript.tsdk
                       (get_typescript_server_path config.root_dir))))}
