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
				ensure_installed = { "lua_ls", "gopls", "pyright" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local tb = require("telescope.builtin")
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
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>ld", function()
				vim.diagnostic.open_float()
			end)
			vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, {})
			vim.keymap.set("n", "<leader>lh", vim.lsp.buf.signature_help, {})
			vim.keymap.set("n", "gd", tb.lsp_definitions, {})
			vim.keymap.set("n", "<leader>lR", tb.lsp_references, {})
			vim.keymap.set("n", "gI", tb.lsp_implementations, {})
			vim.keymap.set("n", "gy", tb.lsp_type_definitions, {})
		end,
	},
	{
		"onsails/lspkind.nvim",
	},
}
