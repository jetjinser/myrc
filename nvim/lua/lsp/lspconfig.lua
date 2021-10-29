require("lsp.racket_ls")

local lsp_installer_servers = require'nvim-lsp-installer.servers'

local function install_lsp(lsp)
require("lsp.racket_ls")

local lsp_installer_servers = require'nvim-lsp-installer.servers'

local function install_lsp(lsp)
    local ok, lua = lsp_installer_servers.get_server(lsp)
    if ok then
        if not lua:is_installed() then
            lua:install()
        end
    end
end

local lsps = {"sumneko_lua", "vimls"}
for _, lsp in ipairs(lsps) do
    install_lsp(lsp)
end

require("nvim-lsp-installer").settings {
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
}
    local ok, lua = lsp_installer_servers.get_server(lsp)
    if ok then
        if not lua:is_installed() then
            lua:install()
        end
    end
end

local lsps = {"sumneko_lua", "vimls"}
for _, lsp in ipairs(lsps) do
    install_lsp(lsp)
end

require("nvim-lsp-installer").settings {
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
}
