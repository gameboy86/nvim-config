local float_diag_grp = vim.api.nvim_create_augroup("float_diagnostic_cursor", { clear = false })

local setLSPClients = function(capa)
	vim.lsp.config("lua_ls", {
		capabilities = capa,
		settings = {
			Lua = {
				completion = {
					callSnippet = "Replace",
				},
			},
		},
	})
	vim.lsp.config("gopls", {
		capabilities = capa,
		on_attach = function(_, bufnr)
			vim.api.nvim_clear_autocmds({ group = float_diag_grp, buffer = bufnr })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				group = float_diag_grp,
				buffer = bufnr,
				callback = function()
					vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
				end,
			})
		end,
	})
	vim.lsp.config("pyright", {
		capabilities = capa,
		on_attach = function(_, bufnr)
			vim.api.nvim_clear_autocmds({ group = float_diag_grp, buffer = bufnr })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				group = float_diag_grp,
				buffer = bufnr,
				callback = function()
					vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
				end,
			})
		end,
	})
	vim.lsp.config("jsonls", {
		capabilities = capa,
		init_options = {
			provideFormatter = true,
		},
	})
	vim.lsp.enable("lua_ls")
	vim.lsp.enable("gopls")
	vim.lsp.enable("pyright")
	vim.lsp.enable("jsonls")
end

return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = { plugins = { "neotest" }, types = true },
		},
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
			local capa = require("cmp_nvim_lsp").default_capabilities()
			capa.offset_encoding = "utf-16"
			capa.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}
			setLSPClients(capa)
		end,
	},
	{
		"onsails/lspkind.nvim",
	},
}
