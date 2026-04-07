local M = {}

function M.setup()
	-- Globalne ustawienie ramek dla wszystkich okien pływających LSP
	local orig = vim.lsp.util.open_floating_preview
	vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or "rounded"
		return orig(contents, syntax, opts, ...)
	end

	-- Linie z vim.lsp.with zostały usunięte, bo powyższa funkcja załatwia sprawę

	local core = require("config.lsp.core")
	local capa = core.capabilities()
	local on_attach_default = core.make_on_attach()

	-- Konfiguracja serwerów
	local servers = { "lua_ls", "gopls", "pyright", "jsonls", "yamlls", "lemminx", "helm_ls" }

	for _, name in ipairs(servers) do
		require("config.lsp.servers." .. name).setup(capa, on_attach_default)
	end

	-- Dodatkowe włączenie (zls nie ma osobnego configu wyżej, więc zostaje w pętli)
	for _, name in ipairs({ "lua_ls", "gopls", "pyright", "jsonls", "yamlls", "lemminx", "helm_ls", "zls" }) do
		vim.lsp.enable(name)
	end
end

function M.keymap()
	require("config.lsp.keymaps").setup()
end

return M
