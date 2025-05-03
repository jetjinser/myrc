(import-macros {: set+ : augroup! : map!} :hibiscus.vim)

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
        vim.lsp.buf.format
        "Format"))

(augroup! :setup-lsp [[LspAttach] * 'setup])

(vim.lsp.enable [:fennel-ls
                 :nil
                 :rust-analyzer
                 :hls])

(vim.diagnostic.config {:virtual_lines {:current_line true}})
