local servers = require("nvim-lsp-installer.servers")
local server = require("nvim-lsp-installer.server")
local std = require("nvim-lsp-installer.installers.std")

local server_name = "racket_langserver"

local root_dir = server.get_server_root_path(server_name)

local racket_server = server.Server:new({
	name = server_name,
	root_dir = root_dir,
	homepage = "https://github.com/jeapostrophe/racket-langserver",
	installer = {
		std.ensure_executables({
			{ "raco", "raco was not found in path. Refer to https://docs.racket-lang.org/pollen/Installation.html." },
		}),
		-- FIXME how to install racket_langserver even it was installed. It cannot return 0
	},
	default_options = {
		cmd = { "racket", "--lib", "racket-langserver" },
		filetypes = { "racket", "scheme" },
	},
})

servers.register(racket_server)
