local M = {}

function M.setup()
	require("gitsigns").setup()
	pcall(function()
		require("telescope").load_extension("git_signs")
	end)
end

function M.keymap()
	local wk = require("which-key")
	local gits = require("gitsigns")
	local tb = require("telescope.builtin")

	wk.add({
		{ "<leader>g", group = "git" },
		{ "<leader>g]", gits.next_hunk, desc = "Next Git hunk" },
		{ "<leader>g[", gits.prev_hunk, desc = "Previous Git hunk" },
		{ "<leader>gl", gits.blame_line, desc = "View Git blame" },
		{ "<leader>gp", gits.preview_hunk, desc = "Preview Git hunk" },
		{ "<leader>gh", gits.reset_hunk, desc = "Reset Git hunk" },
		{ "<leader>gr", gits.reset_buffer, desc = "Reset Git buffer" },
		{ "<leader>gs", gits.stage_hunk, desc = "Stage Git hunk" },
		{ "<leader>gS", gits.stage_buffer, desc = "Stage Git buffer" },
		{ "<leader>gu", gits.undo_stage_hunk, desc = "Unstage Git hunk" },
		{ "<leader>gd", gits.diffthis, desc = "View Git diff" },
		{
			"<leader>gH",
			function()
				vim.cmd("Telescope git_signs")
			end,
			desc = "Git hunks (Telescope)",
		},
		{
			"<leader>gL",
			function()
				require("gitsigns").blame_line({ full = true })
			end,
			desc = "View full Git blame",
		},

		{
			"<leader>gc",
			function()
				tb.git_commits({ use_file_path = true })
			end,
			desc = "View Git commits",
		},
		{
			"<leader>gC",
			function()
				tb.git_bcommits({ use_file_path = true })
			end,
			desc = "View current file Git commits",
		},
		{
			"<leader>ga",
			function()
				tb.git_status({ use_file_path = true })
			end,
			desc = "View Git status",
		},
		{
			"<leader>gb",
			function()
				tb.git_branches({ use_file_path = true })
			end,
			desc = "List Git branches",
		},
	})
end

return M
