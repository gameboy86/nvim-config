return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local actions = require("telescope.actions")
			require("telescope").setup({
				defaults = {
					prompt_prefix = " ",
					selection_caret = " ",
					path_display = { "smart" },
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
						layout_config = {
							width = 80,
						},
					},
					lsp_references = {
						previewer = true,
					},
					git_signs = {
						previewer = true,
					},
				},
			})
			require("telescope").load_extension("git_signs")
			require("telescope").load_extension("noice")
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
