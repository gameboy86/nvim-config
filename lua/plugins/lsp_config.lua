local handlers = {
	["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
		local diagnostic = require("plugins/options/diagnostic")
		diagnostic.MyDiagnosticConfig(ctx.bufnr)
		vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
	end
}

local setLSPClients = function(capa)
	local lspconfig = require("lspconfig")
	lspconfig.lua_ls.setup({
		capabilities = capa,
		handlers = handlers,
		settings = {
			Lua = {
				completion = {
					callSnippet = "Replace",
				},
			},
		},
	})
	lspconfig.gopls.setup({
		capabilities = capa,
		handlers = handlers,
		on_attach = function()
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				group = vim.api.nvim_create_augroup("float_diagnostic_cursor", { clear = true }),
				callback = function()
					vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
				end
			})
		end
	})
	lspconfig.pyright.setup({
		capabilities = capa,
		handlers = handlers,
	})
	lspconfig.jsonls.setup({
		capabilities = capa,
		provideFormatter = true,
		handlers = handlers,
	})
end

return {
	{
		"folke/neodev.nvim",
		opts = {},
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
				ensure_installed = { "lua_ls", "gopls", "pyright", "jsonls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("neodev").setup({
				library = { plugins = { "neotest" }, types = true },
			})
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
