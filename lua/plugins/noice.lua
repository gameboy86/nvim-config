return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	opts = {
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
		notify = { enabled = false },
		views = {
			cmdline_popup = {
				position = {
					row = "50%",
					col = "50%",
				},
			},
		},
		routes = {
			{
				-- Hide LSP progress notifications coming from the null-ls client
				-- (they can be very noisy when running formatters/linters).
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
				-- Hide generic "more line(s)" messages when scrolling or opening files.
				filter = {
					event = "msg_show",
					kind = "",
					find = "more line",
				},
				opts = { skip = true },
			},
			{
				-- Hide the standard "X lines, Y bytes" message shown after opening/writing a file.
				filter = {
					event = "msg_show",
					find = "%d+L, %d+B",
				},
				opts = { skip = true },
			},
			{
				-- Hide "N more lines" messages that show up when pasting/yanking multiple lines.
				filter = {
					event = "msg_show",
					kind = "",
					find = "%d+ more lines?",
				},
				opts = { skip = true },
			},
			-- {
			-- 	-- Hide deprecation warnings (e.g. "vim.tbl_islist is deprecated")
			-- 	-- from Noice popups, but they will still be available in :messages.
			-- 	filter = {
			-- 		event = "msg_show",
			-- 		kind = "wmsg", -- warning message
			-- 		find = "is deprecated",
			-- 	},
			-- 	opts = { skip = true },
			-- },
			{
				-- Hide the specific deprecation warning popup from Noice,
				-- but keep it in :messages (Noice only hides its own view).
				filter = {
					event = "msg_show",
					-- bez kind = ..., łapiemy każdy msg_show zawierający ten tekst
					find = "is deprecated",
					-- jeśli kiedyś pojawi się więcej deprecations, możesz
					-- zmienić to na samo "is deprecated"
				},
				opts = { skip = true },
			},
		},
	},
}
