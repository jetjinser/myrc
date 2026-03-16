(local root-files [:settings.gradle
                   :settings.gradle.kts
                   :build.xml
                   :pom.xml
                   :build.gradle
                   :build.gradle.kts])
{:cmd [:kotlin-language-server]
 :filetypes [:kotlin]
 :init_options {:storagePath (vim.fs.root (vim.fn.expand "%:p:h") root-files)}
 :root_markers root-files
 :settings {:kotlin {:compiler {:jvm {:target "21"}}}}}
