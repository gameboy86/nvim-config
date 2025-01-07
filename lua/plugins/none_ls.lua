return {
	"nvimtools/none-ls.nvim",
	config = function()
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.code_actions.gomodifytags,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.gofmt,
				null_ls.builtins.formatting.golines,
				null_ls.builtins.formatting.goimports,
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.isort,
				-- null_ls.builtins.formatting.yamlfix,
				-- null_ls.builtins.formatting.yamlfmt,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.diagnostics.golangci_lint,
			},
			on_attach = function(client, bufnr)
				local format = function()
					vim.lsp.buf.format({ async = false })
				end
				if client.server_capabilities.documentFormattingProvider then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = format,
					})
				end
			end,
		})
	end,
}
