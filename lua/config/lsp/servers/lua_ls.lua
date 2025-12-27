local M = {}

function M.setup(capa, on_attach)
	vim.lsp.config("lua_ls", {
		capabilities = capa,
		on_attach = on_attach,
		settings = {
			Lua = {
				completion = { callSnippet = "Replace" },
				diagnostics = {
					globals = { "vim" },
					disable = { "different-requires" },
				},
			},
		},
	})
end

return M
