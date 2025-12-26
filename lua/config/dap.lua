local M = {}

function M.setup()
	-- UI (signs/highlights)
	require("config.dap.ui").setup()

	-- Go adapter config
	require("config.dap.go").setup()

	-- virtual text
	require("nvim-dap-virtual-text").setup()
end

function M.keymap()
	local wk = require("which-key")

	wk.add({
		{ "<leader>d", group = "dap" },

		{ "<leader>dt", "<cmd>DapToggleBreakpoint<CR>", desc = "Toggle breakpoint" },
		{ "<leader>dc", "<cmd>DapContinue<CR>", desc = "Continue" },
		{ "<leader>dx", "<cmd>DapTerminate<CR>", desc = "Terminate" },

		{ "<leader>do", "<cmd>DapStepOver<CR>", desc = "Step over" },

		{ "<leader>di", "<cmd>DapStepInto<CR>", desc = "Step into" },
		{ "<leader>dO", "<cmd>DapStepOut<CR>", desc = "Step out" },

		{
			"<leader>dh",
			function()
				local win = vim.api.nvim_get_current_win()
				if vim.api.nvim_win_get_config(win).relative ~= "" then
					vim.api.nvim_win_close(win, true)
				else
					require("dap.ui.widgets").hover()
				end
			end,
			desc = "DAP hover toggle",
		},

		-- DAP VIEW (nvim-dap-view)
		{ "<leader>dv", group = "view" },
		{ "<leader>dvt", "<cmd>DapViewToggle<CR>", desc = "View toggle" },
		{ "<leader>dvo", "<cmd>DapViewOpen<CR>", desc = "View open" },
		{ "<leader>dvc", "<cmd>DapViewClose<CR>", desc = "View close" },
	})
end

return M
