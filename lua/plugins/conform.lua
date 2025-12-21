return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	opts = {
		format_on_save = {
			timeout_ms = 2000,
			lsp_fallback = false,
		},
		formatters_by_ft = {
			go = { "goimports", "gofmt", "golines" },
			python = { "isort", "black" },
			json = { "prettier" },
			jsonc = { "prettier" },

			yaml = { "yamlfmt" }, -- albo "yamlfmt"
			yml = { "yamlfmt" }, -- czasem filetype bywa "yaml" tylko, ale możesz zostawić

			xml = { "xmllint" },
			lua = { "stylua" },
		},
	},
}
