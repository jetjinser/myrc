(import-macros {: set! : set+ : augroup!} :hibiscus.vim)

(fn setup [ev]
  (let [client (vim.lsp.get_client_by_id ev.data.client_id)]
    (when (client:supports_method :textDocument/completion)
          (vim.lsp.completion.enable true client.id
                                     ev.buf {:autotrigger true}))))
(augroup! :setup-lsp [[LspAttach] * 'setup])

(set+ completeopt :noselect)

(vim.lsp.config :fennel-ls
  {:settings {:fennel {:workspace {:library (vim.api.nvim_list_runtime_paths)}}}})

(vim.lsp.enable [:fennel-ls])

(vim.diagnostic.config {:virtual_lines {:current_line true}})
