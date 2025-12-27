local M = {}

function M.setup(capa, on_attach)
	vim.lsp.config("pyright", {
		capabilities = capa,
		on_attach = on_attach,
	})
end

return M
