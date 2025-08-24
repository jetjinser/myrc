(require :options)
(require :mappings)
(require :lang)
(require :filetype)

(let [lazy (require :lazy)
      plugins (require :plugins)
      spec plugins
      opts {:spec spec
            :checker {:enabled false}
            :defaults {:lazy true}
            :install {:colorscheme [:rose-pine]}
            :performance {:rtp {:reset false} :reset_packpath false}}]
  (lazy.setup opts))

