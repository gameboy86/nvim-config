local M = {}

function M.setup()
	local core = require("config.lsp.core")
	local capa = core.capabilities()

	local on_attach_default = core.make_on_attach()
	local on_attach_with_float = core.make_on_attach(function(_, bufnr)
		core.attach_float_diagnostics(bufnr)
	end)

	require("config.lsp.servers.lua_ls").setup(capa, on_attach_default)
	require("config.lsp.servers.gopls").setup(capa, on_attach_with_float)
	require("config.lsp.servers.pyright").setup(capa, on_attach_with_float)
	require("config.lsp.servers.jsonls").setup(capa, on_attach_default)
	require("config.lsp.servers.yamlls").setup(capa, on_attach_default)
	require("config.lsp.servers.lemminx").setup(capa, on_attach_default)
	require("config.lsp.servers.helm_ls").setup(capa, on_attach_default)

	for _, name in ipairs({ "lua_ls", "gopls", "pyright", "jsonls", "yamlls", "lemminx", "helm_ls" }) do
		vim.lsp.enable(name)
	end
end

function M.keymap()
	require("config.lsp.keymaps").setup()
end

return M
