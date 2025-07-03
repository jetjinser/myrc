{:cmd [:vscode-eslint-language-server :--stdio]
 :workspace_required true
 :filetypes [:javascript
             :javascriptreact
             :javascript.jsx
             :typescript
             :typescriptreact
             :typescript.tsx
             :vue
             :svelte
             :astro]
 :root_markers [:.eslintrc
                :.eslintrc.js
                :.eslintrc.cjs
                :.eslintrc.yaml
                :.eslintrc.yml
                :.eslintrc.json
                :eslint.config.js
                :eslint.config.mjs
                :eslint.config.cjs
                :eslint.config.ts
                :eslint.config.mts
                :eslint.config.cts]
 :settings {:codeAction {:disableRuleComment {:enable true :location :separateLine}
                         :showDocumentation {:enable true}}
            :codeActionOnSave {:enable false :mode :all}
            :experimental {:useFlatConfig false}
            :format false
            :nodePath ""
            :onIgnoredFiles :off
            :packageManager nil
            :problems {:shortenToSingleLine false}
            :quiet false
            :rulesCustomizations {}
            :run :onSave
            :useESLintClass false
            :validate :on
            :workingDirectory {:mode :location}}
 :before_init
  (fn [_ config]
    (let [root-dir config.root_dir]
      (when root-dir
        (set config.settings (or config.settings {}))
        (set config.settings.workspaceFolder
             {:name (vim.fn.fnamemodify root-dir ":t") :uri root-dir})
        (local flat-config-files
               [:eslint.config.js
                :eslint.config.mjs
                :eslint.config.cjs
                :eslint.config.ts
                :eslint.config.mts
                :eslint.config.cts])
        (each [_ file (ipairs flat-config-files)]
          (when (= (vim.fn.filereadable (.. root-dir "/" file)) 1)
            (set config.settings.experimental
                 (or config.settings.experimental {}))
            (set config.settings.experimental.useFlatConfig true)
            (lua :break)))
        (local pnp-cjs (.. root-dir :/.pnp.cjs))
        (local pnp-js (.. root-dir :/.pnp.js))
        (when (or (vim.uv.fs_stat pnp-cjs) (vim.uv.fs_stat pnp-js))
          (local cmd config.cmd)
          (set config.cmd (vim.list_extend [:yarn :exec] cmd))))))
 :handlers {:eslint/openDoc (fn [_ result] (when result (vim.ui.open result.url)) {})
            :eslint/confirmESLintExecution (fn [_ result] (if result 4 nil))
            :eslint/noLibrary (fn []
                                (vim.notify "Unable to find ESLint library."
                                        vim.log.levels.WARN)
                                {})
            :eslint/probeFailed (fn []
                                  (vim.notify "ESLint probe failed."
                                              vim.log.levels.WARN)
                                  {})}}
