local M = {}

function M.setup()
	do
		local orig = vim.lsp.util.open_floating_preview
		vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
			opts = opts or {}
			opts.border = opts.border or "rounded"
			return orig(contents, syntax, opts, ...)
		end
	end

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

	vim.lsp.handlers["textDocument/signatureHelp"] =
		vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

	local core = require("config.lsp.core")
	local capa = core.capabilities()

	local on_attach_default = core.make_on_attach()

	require("config.lsp.servers.lua_ls").setup(capa, on_attach_default)
	require("config.lsp.servers.gopls").setup(capa, on_attach_default)
	require("config.lsp.servers.pyright").setup(capa, on_attach_default)
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
