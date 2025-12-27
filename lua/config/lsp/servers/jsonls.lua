local M = {}

function M.setup(capa, on_attach)
	vim.lsp.config("jsonls", {
		capabilities = capa,
		on_attach = on_attach,
		init_options = { provideFormatter = true },
	})
end

return M
