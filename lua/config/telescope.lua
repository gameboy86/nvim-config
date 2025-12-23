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
			file_ignore_patterns = { "node_modules", ".git", ".venv", "dist/" },
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
	pcall(telescope.load_extension, "git_signs")
	pcall(telescope.load_extension, "noice")
end

return M
