(local parser-config
       ((. (require :nvim-treesitter.parsers) :get_parser_configs)))
(set parser-config.bqn
     {:filetype :bqn
      :install_info {:branch :main
                     :files [:src/parser.c]
                     :generate_requires_npm false
                     :requires_generate_from_grammar false
                     :url "https://github.com/shnarazk/tree-sitter-bqn"}})
