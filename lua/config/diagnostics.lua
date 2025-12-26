local M = {}

function M.keymap()
	local wk = require("which-key")
	local tb = require("telescope.builtin")

	wk.add({
		{ "<leader>x", group = "diagnostics" },

		{ "<leader>xF", tb.diagnostics, desc = "Workspace diagnostics" },
		{
			"<leader>xf",
			function()
				tb.diagnostics({ bufnr = 0 })
			end,
			desc = "Buffer diagnostics",
		},
		{
			"<leader>xd",
			function()
				vim.diagnostic.open_float()
			end,
			desc = "Hover diagnostics",
		},
		{ "<leader>xt", "<cmd>TodoTelescope<cr>", desc = "Todo (telescope)" },
		{ "<leader>xq", "<cmd>TodoQuickFix<cr>", desc = "Todo (quick fix)" },
	})
end

return M
