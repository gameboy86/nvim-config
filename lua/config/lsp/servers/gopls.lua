local M = {}

function M.setup(capa, on_attach)
	vim.lsp.config("gopls", {
		capabilities = capa,
		on_attach = on_attach,
		-- Dodaj wspierane typy plików:
		filetypes = { "go", "gomod", "gowork", "gotmpl" },
		settings = {
			gopls = {
				-- Informuje serwer o rozszerzeniach szablonów
				["build.templateExtensions"] = { "tmpl", "gotmpl" },
			},
		},
	})
end
return M
