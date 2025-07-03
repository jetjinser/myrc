(import-macros {: set+ : augroup! : map!} :hibiscus.vim)

(fn diagnostic_goto [next severity*]
  (let [go       (or (and next vim.diagnostic.goto_next)
                     vim.diagnostic.goto_prev)
        severity (or (and severity*)
                     (. vim.diagnostic.severity severity*)
                     nil)]
    (fn [] (go {: severity}))))

(fn setup [ev]
  (map! [n :buffer] "<leader>cit"
        #(let [ih vim.lsp.inlay_hint]
           (ih.enable (not (ih.is_enabled))))
        "Toggle Inlay Hints")
  (map! [n :buffer] "<leader>cia"
        #(let [ih vim.lsp.inlay_hint
               current-buffer (vim.api.nvim_get_current_buf)
               cursor (vim.api.nvim_win_get_cursor 0)
               row (- (. cursor 1) 1)
               range {:end {:character 1000 :line row}
                      :start {:character 0 :line row}}
               hints (ih.get {:bufnr current-buffer : range})]
           (each [_ hint (ipairs hints)] (vim.print hint.inlay_hint.textEdits)
             (vim.lsp.util.apply_text_edits hint.inlay_hint.textEdits current-buffer
                                                       :utf-8
                   "Apply Current Line Inlay Hints textEdits"))))

  (map! [n :buffer] "<leader>cf"
        #(vim.lsp.buf.format {:filter (fn [client] (not= client.name :ts_ls))})
        "Format")

  (map! [n :buffer] "gd" vim.lsp.buf.definition "Goto Definition")

  (map! [nv :buffer] "]d" (diagnostic_goto true)         "Next Diagnostic")
  (map! [nv :buffer] "[d" (diagnostic_goto false)        "Prev Diagnostic")
  (map! [nv :buffer] "]e" (diagnostic_goto true  :ERROR) "Next Error")
  (map! [nv :buffer] "[e" (diagnostic_goto false :ERROR) "Prev Error")
  (map! [nv :buffer] "]w" (diagnostic_goto true  :WARN)  "Next Warning")
  (map! [nv :buffer] "[w" (diagnostic_goto false :WARN)  "Prev Warning"))

(augroup! :setup-lsp [[LspAttach] * 'setup])

(vim.lsp.enable [:efm
                 :fennel-ls
                 :nil
                 :rust-analyzer
                 :hls
                 :svelte
                 :vue_ls
                 :eslint
                 :html
                 :ts_ls
                 :cssls
                 :slint_lsp
                 :ocamllsp])

(vim.diagnostic.config {:virtual_lines {:current_line true}})
