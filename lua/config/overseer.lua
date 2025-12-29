local M = {}

function M.setup(overseer_opts)
	require("overseer").setup(overseer_opts or {})

	local telescope = require("telescope")
	telescope.setup({
		extensions = {
			["ui-select"] = require("telescope.themes").get_dropdown({}),
		},
	})
	telescope.load_extension("ui-select")
end

function M.keymap()
	local wk = require("which-key")

	wk.add({
		{ "<leader>r", group = "Overseer" },
		{ "<leader>rr", "<cmd>OverseerRun<cr>", desc = "Run task (Make targets)" },
		{ "<leader>rt", "<cmd>OverseerToggle<cr>", desc = "Toggle task list" },
	})
end

return M
