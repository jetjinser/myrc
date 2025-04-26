#!/usr/bin/env bash

TMP=$(mktemp -d /tmp/docset-XXXXXX)
git clone https://git.sr.ht/~micampe/fennel-ls-nvim-docs "$TMP"

mkdir -p $HOME/.local/share/fennel-ls/docsets
cp "$TMP/nvim.lua" $HOME/.local/share/fennel-ls/docsets/nvim.lua
rm -rf "$TMP"
