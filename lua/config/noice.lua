local M = {}

function M.opts()
	return {
		popupmenu = {
			enabled = true,
			backend = "cmp",
		},
		lsp = {
			hover = { enabled = true },
			signature = { enabled = true },
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		presets = {
			bottom_search = true,
			command_palette = true,
			long_message_to_split = true,
			lsp_doc_border = true,
		},
		messages = { enabled = true, view = "notify" },
		notify = { enabled = true },
		views = {
			cmdline_popup = {
				position = { row = "50%", col = "50%" },
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
				filter = { event = "msg_show", kind = "", find = "more line" },
				opts = { skip = true },
			},
			{
				filter = { event = "msg_show", find = "%d+L, %d+B" },
				opts = { skip = true },
			},
			{
				filter = { event = "msg_show", kind = "", find = "%d+ more lines?" },
				opts = { skip = true },
			},
			{
				filter = { event = "msg_show", find = "is deprecated" },
				opts = { skip = true },
			},
		},
	}
end

function M.keymap()
	local wk = require("which-key")

	wk.add({
		{ "<leader>n", group = "noice" },
		{ "<leader>nn", "<cmd>Noice<cr>", desc = "Noice: UI" },
		{ "<leader>nh", "<cmd>Noice history<cr>", desc = "Noice: history" },
		{ "<leader>nd", "<cmd>Noice dismiss<cr>", desc = "Noice: dismiss" },
		{ "<leader>ne", "<cmd>Noice errors<cr>", desc = "Noice: errors" },
		{ "<leader>nl", "<cmd>Noice last<cr>", desc = "Noice: last message" },
	})
end

return M
