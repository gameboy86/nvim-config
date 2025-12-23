local M = {}

function M.opts()
	return {
		format_on_save = {
			timeout_ms = 2000,
			lsp_fallback = false,
		},
		formatters_by_ft = {
			go = { "goimports", "gofmt", "golines" },
			python = { "isort", "black" },

			json = { "prettier" },
			jsonc = { "prettier" },

			yaml = { "yamlfmt" },
			yml = { "yamlfmt" },

			xml = { "xmllint" },
			lua = { "stylua" },
		},
	}
end

return M
