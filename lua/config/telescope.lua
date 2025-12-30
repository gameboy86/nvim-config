local M = {}

function M.setup()
	local actions = require("telescope.actions")
	local themes = require("telescope.themes")
	local telescope = require("telescope")

	telescope.setup({
		defaults = {
			prompt_prefix = " ",
			selection_caret = " ",
			path_display = { "absolute" },
			mappings = {
				i = {
					["<C-n>"] = actions.cycle_history_next,
					["<C-p>"] = actions.cycle_history_prev,
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
				},
				n = { q = actions.close },
			},
		},
		pickers = {
			live_grep = {
				additional_args = function(_)
					return { "--hidden" }
				end,
			},
			find_files = {
				hidden = true,
			},
			buffers = {
				previewer = false,
				layout_config = { width = 80 },
			},
			lsp_references = {
				previewer = true,
				path_display = { "smart" },
				layout_config = { width = 0.95 },
				fname_width = 90,
			},
		},
		extensions = {
			["ui-select"] = themes.get_dropdown({}),
		},
	})
	telescope.load_extension("ui-select")
	pcall(telescope.load_extension, "noice")
end

function M.keymap()
	local wk = require("which-key")
	local tb = require("telescope.builtin")
	local telescope_ui = require("config.messages.telescope")

	wk.add({
		{ "<leader>f", group = "telescope" },
		{ "<leader>ff", tb.find_files, desc = "Find files" },
		{ "<leader>fb", tb.buffers, desc = "List buffers" },
		{ "<leader>fw", tb.live_grep, desc = "Live grep" },
		{ "<leader>fo", tb.oldfiles, desc = "Find history" },
		{ "<leader>ft", tb.help_tags, desc = "Find help" },
		{
			"<leader>fo",
			function()
				tb.oldfiles({ cwd_only = true })
			end,
			desc = "Recent files (project)",
		},
		{ "<leader>fr", tb.registers, desc = "List registers" },
		{
			"<leader>fm",
			function()
				telescope_ui.open()
			end,
			desc = "Open :messages",
		},
	})
end

return M
