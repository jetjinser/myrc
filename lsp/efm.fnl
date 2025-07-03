(local *prettier* "./node_modules/.bin/prettier")
(fn prettier-fmt [parser]
  (table.concat [*prettier*
                 "--stdin"
                 "--stdin-filepath"
                 "'${INPUT}'"
                 (and parser (.. "--parser " parser))]
                " "))

(local languages {:html       [{:formatCommand (prettier-fmt :html)       :formatCanRange true :formatStdin true}]
                  :css        [{:formatCommand (prettier-fmt :css)        :formatCanRange true :formatStdin true}]
                  :javascript [{:formatCommand (prettier-fmt :javascript) :formatCanRange true :formatStdin true}]
                  :typescript [{:formatCommand (prettier-fmt :typescript) :formatCanRange true :formatStdin true}]
                  :svelte     [{:formatCommand (prettier-fmt :svelte)     :formatCanRange true :formatStdin true}]})

{:cmd [:efm-langserver]
 :root_markers [:.git]
 :filetypes [:html :css :javascript :typescript :svelte]
 :init_options {:documentFormatting true
                :documentRangeFormatting true
                :hover true
                :documentSymbol true
                :codeAction true
                :completion true}
 :settings {:rootMarkers [:.git/]
            : languages}}

