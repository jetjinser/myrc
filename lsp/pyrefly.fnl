{:cmd [:pyrefly :lsp]
 :filetypes [:python]
 :on_exit (fn [code _ _]
            (vim.notify (.. "Closing Pyrefly LSP exited with code: " code)
                        vim.log.levels.INFO))
 :root_markers [:pyrefly.toml
                :pyproject.toml
                :setup.py
                :setup.cfg
                :requirements.txt
                :Pipfile
                :.git]}
