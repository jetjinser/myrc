(import-macros {: set+ : augroup!} :hibiscus.vim)

; (fn setup [ev]
;   (let [client (vim.lsp.get_client_by_id ev.data.client_id)]
;     (when (client:supports_method :textDocument/completion)
;           (vim.lsp.completion.enable true client.id
;                                      ev.buf {:autotrigger true}))))
; (augroup! :setup-lsp [[LspAttach] * 'setup])
;
; (set+ completeopt :noselect)

(vim.lsp.enable [:fennel-ls
                 :nil
                 :rust-analyzer])

(vim.diagnostic.config {:virtual_lines {:current_line true}})
