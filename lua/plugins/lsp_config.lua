return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "gopls", "pyright", "jsonls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- local tb = require("telescope.builtin")
			local capa = require("cmp_nvim_lsp").default_capabilities()

			capa.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities = capa,
			})
			lspconfig.gopls.setup({
				capabilities = capa,
			})
			lspconfig.pyright.setup({
				capabilities = capa,
			})
			lspconfig.jsonls.setup({
				capabilities = capa,
				provideFormatter = true,
			})
		end,
	},
	{
		"onsails/lspkind.nvim",
	},
}
