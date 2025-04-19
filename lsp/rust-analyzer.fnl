{:cmd [:rust-analyzer]
 :filetypes [:rust]
 :root_markers [:Cargo.toml :.git]
 :capabilities {:experimental {:serverStatusNotification true}}
 :settings {:rust-analyzer {:checkOnSave {:allTargets false}
                            :cargo {:cfgs [:kani]}
                            :completion {:termSearch {:enable true}}
                            :hover {:memoryLayout {:niches true}}}}}
