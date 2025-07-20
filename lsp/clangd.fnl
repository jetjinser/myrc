(fn switch-source-header [bufnr]
  (let [method-name :textDocument/switchSourceHeader
        client (. (vim.lsp.get_clients {: bufnr :name :clangd}) 1)]
    (when (not client)
      (let [___antifnl_rtns_1___ [(vim.notify (: "method %s is not supported by any servers active on the current buffer"
                                                 :format method-name))]]
        (lua "return (table.unpack or _G.unpack)(___antifnl_rtns_1___)")))
    (local params (vim.lsp.util.make_text_document_params bufnr))
    (client.request method-name params
                    (fn [err result]
                      (when err (error (tostring err)))
                      (when (not result)
                        (vim.notify "corresponding file cannot be determined")
                        (lua "return "))
                      (vim.cmd.edit (vim.uri_to_fname result)))
                    bufnr)))
(fn symbol-info []
  (let [bufnr (vim.api.nvim_get_current_buf)
        clangd-client (. (vim.lsp.get_clients {: bufnr :name :clangd}) 1)]
    (when (or (not clangd-client)
              (not (clangd-client.supports_method :textDocument/symbolInfo)))
      (let [___antifnl_rtns_1___ [(vim.notify "Clangd client not found"
                                              vim.log.levels.ERROR)]]
        (lua "return (table.unpack or _G.unpack)(___antifnl_rtns_1___)")))
    (local win (vim.api.nvim_get_current_win))
    (local params
           (vim.lsp.util.make_position_params win clangd-client.offset_encoding))
    (clangd-client.request :textDocument/symbolInfo params
                           (fn [err res]
                             (when (or err (= (length res) 0))
                               (lua "return "))
                             (local container
                                    (string.format "container: %s"
                                                   (. res 1 :containerName)))
                             (local name
                                    (string.format "name: %s" (. res 1 :name)))
                             (vim.lsp.util.open_floating_preview [name
                                                                  container]
                                                                 ""
                                                                 {:border :single
                                                                  :focus false
                                                                  :focusable false
                                                                  :height 2
                                                                  :title "Symbol Info"
                                                                  :width (math.max (string.len name)
                                                                                   (string.len container))}))
                           bufnr)))
{:capabilities {:offsetEncoding [:utf-8 :utf-16]
                :textDocument {:completion {:editsNearCursor true}}}
 :cmd [:clangd]
 :filetypes [:c :cpp :objc :objcpp :cuda :proto]
 :on_attach (fn [_ bufnr]
              (vim.api.nvim_buf_create_user_command bufnr
                                                    :LspClangdSwitchSourceHeader
                                                    (fn []
                                                      (switch-source-header bufnr))
                                                    {:desc "Switch between source/header"})
              (vim.api.nvim_buf_create_user_command bufnr
                                                    :LspClangdShowSymbolInfo
                                                    (fn [] (symbol-info))
                                                    {:desc "Show symbol info"}))
 :on_init (fn [client init-result]
            (when init-result.offsetEncoding
              (set client.offset_encoding init-result.offsetEncoding)))
 :root_markers [:.clangd
                :.clang-tidy
                :.clang-format
                :compile_commands.json
                :compile_flags.txt
                :configure.ac
                :.git]}  
