(var mod-cache nil)
(var std-lib nil)
(fn identify-go-dir [custom-args on-complete]
  (let [cmd [:go :env custom-args.envvar_id]]
    (vim.system cmd {:text true}
                (fn [output]
                  (var res (vim.trim (or output.stdout "")))
                  (if (and (= output.code 0) (not= res ""))
                      (do
                        (when (and custom-args.custom_subdir
                                   (not= custom-args.custom_subdir ""))
                          (set res (.. res custom-args.custom_subdir)))
                        (on-complete res))
                      (do
                        (vim.schedule (fn []
                                        (vim.notify (: (.. "[gopls] identify "
                                                           custom-args.envvar_id
                                                           " dir cmd failed with code %d: %s
%s") :format output.code
                                                       (vim.inspect cmd)
                                                       output.stderr))))
                        (on-complete nil)))))))
(fn get-std-lib-dir []
  (when (and std-lib (not= std-lib ""))
    (let [___antifnl_rtn_1___ std-lib] (lua "return ___antifnl_rtn_1___")))
  (identify-go-dir {:custom_subdir :/src :envvar_id :GOROOT}
                   (fn [dir] (when dir (set std-lib dir))))
  std-lib)
(fn get-mod-cache-dir []
  (when (and mod-cache (not= mod-cache ""))
    (let [___antifnl_rtn_1___ mod-cache] (lua "return ___antifnl_rtn_1___")))
  (identify-go-dir {:envvar_id :GOMODCACHE}
                   (fn [dir] (when dir (set mod-cache dir))))
  mod-cache)
(fn get-root-dir [fname]
  (when (and mod-cache (= (fname:sub 1 (length mod-cache)) mod-cache))
    (local clients (vim.lsp.get_clients {:name :gopls}))
    (when (> (length clients) 0)
      (let [___antifnl_rtn_1___ (. clients (length clients) :config :root_dir)]
        (lua "return ___antifnl_rtn_1___"))))
  (when (and std-lib (= (fname:sub 1 (length std-lib)) std-lib))
    (local clients (vim.lsp.get_clients {:name :gopls}))
    (when (> (length clients) 0)
      (let [___antifnl_rtn_1___ (. clients (length clients) :config :root_dir)]
        (lua "return ___antifnl_rtn_1___"))))
  (or (or (vim.fs.root fname :go.work) (vim.fs.root fname :go.mod))
      (vim.fs.root fname :.git)))
{:cmd [:gopls]
 :filetypes [:go :gomod :gowork :gotmpl]
 :root_dir (fn [bufnr on-dir] (local fname (vim.api.nvim_buf_get_name bufnr))
             (get-mod-cache-dir)
             (get-std-lib-dir)
             (on-dir (get-root-dir fname)))}
