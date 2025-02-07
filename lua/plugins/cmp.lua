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
			"hrsh7th/cmp-cmdline",
			"rcarriga/cmp-dap",
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
			local enable_f = function()
				return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
			end
			local snippet_expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end
			cmp.setup.cmdline('/', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'buffer' }
				}
			})
			cmp.setup.cmdline('/', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'buffer' }
				}
			})
			cmp.setup({
				enabled = enable_f,
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = lspkind.cmp_format(lspkind_options),
				},
				snippet = {
					expand = snippet_expand,
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
					{ name = "luasnip",  priority = 750 },
					{ name = "buffer",   priority = 500 },
					{ name = "path",     priority = 250 },
					{ name = "cmdline",     priority = 150 },
				}),
			})
			require("cmp").setup.filetype({
				"dap-repl",
				"dapui_watches",
				"dapui_hover",
			}, {
				sources = {
					{ name = "dap" },
				},
			})
		end,
	},
}
