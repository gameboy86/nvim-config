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
			-- local enable_f = function()
			-- 	return vim.bo.buftype ~= "prompt" or require("cmp_dap").is_dap_buffer()
			-- end

			local enable_f = function()
				local mode = vim.api.nvim_get_mode().mode

				-- cmdline (np. : , / , ? , input())
				if mode == "c" then
					local t = vim.fn.getcmdtype()
					-- pozwól cmp TYLKO dla :, /, ?
					if t == ":" or t == "/" or t == "?" then
						return true
					end
					-- dla input() (t == '@') -> wyłącz cmp
					return false
				end

				-- normalne bufory / DAP
				if vim.bo.buftype == "prompt" then
					local ok, cmp_dap = pcall(require, "cmp_dap")
					if ok and cmp_dap.is_dap_buffer() then
						return true
					end
					return false
				end

				return true
			end
			local snippet_expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end
			local cmdline_mapping = {
				["<C-j>"] = { c = cmp.mapping.select_next_item() },
				["<C-k>"] = { c = cmp.mapping.select_prev_item() },
				["<CR>"] = { c = cmp.mapping.confirm({ select = false }) },
				["<C-e>"] = { c = cmp.mapping.abort() },
			}

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmdline_mapping,
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmdline_mapping,
				sources = cmp.config.sources({
					{ name = "path" },
					{ name = "cmdline" },
				}),
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
					["<Leader><Leader>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-j>"] = cmp.mapping(function(fallback)
						local luasnip = require("luasnip")
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<C-k>"] = cmp.mapping(function(fallback)
						local luasnip = require("luasnip")
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp",        priority = 1000 },
					{ name = "luasnip",         priority = 750 },
					{ name = "path",            priority = 500 },
					{ name = "render-markdown", priority = 400 },
					{ name = "buffer",          priority = 200 },
				}),
				sorting = {
					comparators = {
						cmp.config.compare.kind,
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.score,
					},
				},
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
