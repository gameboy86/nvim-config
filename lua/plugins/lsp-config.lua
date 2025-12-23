return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
	},
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
				ensure_installed = { "lua_ls", "gopls", "pyright", "jsonls", "yamlls", "lemminx", "helm_ls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("config.lsp").setup_servers()
		end,
	},
	{ "onsails/lspkind.nvim" },
}
