{:cmd [:vscode-html-language-server :--stdio]
 :filetypes [:html :templ]
 :root_markers [:package.json :.git]
 :init_options {:provideFormatter false
                :embeddedLanguages {:css true :javascript true}
                :configurationSection [:html :css :javascript]}}
