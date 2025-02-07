return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {},
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	lsp = {
		hover = {
			enabled = true,
		},
		signature = {
			enabled = true,
		},
		override = {
			['vim.lsp.util.convert_input_to_markdown_lines'] = true,
			['vim.lsp.util.stylize_markdown'] = true,
			['cmp.entry.get_documentation'] = true,
		},
	},
	routes = {
		{
			filter = {
				event = "lsp",
				kind = "progress",
				cond = function(message)
					local client = vim.tbl_get(message.opts, "progress", "client")
					return client == "null-ls"
				end,
			},

			opts = { skip = true },
		},
		{
			filter = {
				event = 'msg_show',
				kind = '',
				find = 'more line',
			},
			opts = { skip = true },
		}
	},
}
