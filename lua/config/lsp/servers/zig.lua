local M = {}

function M.setup(capa, on_attach)
	vim.lsp.config("zls", {
		capabilities = capa,
		on_attach = on_attach,
		settings = {
			zls = {
				enable_inlay_hints = true,
				enable_snippets = true,
				warn_style = true,
			},
		},
	})
end

return M
