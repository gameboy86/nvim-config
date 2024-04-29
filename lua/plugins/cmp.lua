return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")
			local lspkind_options = require("plugins.options.lspkind")
			require("luasnip.loaders.from_vscode").lazy_load()
			local border_opts = {
				border = "rounded",
				winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
			}
			cmp.setup({
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = lspkind.cmp_format(lspkind_options),
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(border_opts),
					documentation = cmp.config.window.bordered(border_opts),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<Leader><Leader>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<tab>"] = cmp.mapping.select_next_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-k>"] = cmp.mapping.select_prev_item(),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp", priority = 1000 },
					{ name = "luasnip", priority = 750 },
					{ name = "buffer", priority = 500 },
					{ name = "path", priority = 250 },
				}),
				-- sources = cmp.config.sources({
				--
				-- 	{ name = "nvim_lsp" },
				-- 	{ name = "luasnip" },
				-- 	{
				-- 		name = "buffer",
				-- 		option = {
				-- 			get_bufnrs = function()
				-- 				return vim.api.nvim_list_bufs()
				-- 			end,
				-- 		},
				-- 	},
				-- 	{ name = "path" },
				-- }, {}),
			})
		end,
	},
}
