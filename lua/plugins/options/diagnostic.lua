local M = {}

local diagnosticConfig = {
	underline = true,
	virtual_text = false,
	update_in_insert = false,
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = " ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
}

function M.MyDiagnosticConfig(bufnr)
	vim.diagnostic.config(diagnosticConfig, bufnr)
end

return M
