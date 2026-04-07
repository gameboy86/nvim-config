local M = {}

function M.setup(capa, on_attach)
	vim.lsp.config("pyright", {
		capabilities = capa,
		on_attach = on_attach,
		settings = {
			python = {
				analysis = {
					diagnosticMode = "workspace",
					useLibraryCodeForTypes = true,
					autoSearchPaths = true,
				},
			},
		},
	})
end

return M
