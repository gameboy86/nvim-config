-- config/diagnostics/keymaps.lua
-- which-key mappings for diagnostics + todo picker.
-- Keeps telescope requires inside callbacks (lazy-friendly).

local M = {}

function M.setup()
	local wk = require("which-key")
	local tb = require("telescope.builtin")

	wk.add({
		{ "<leader>x", group = "diagnostics" },
		{
			"<leader>xF",
			function()
				tb.diagnostics({ previewer = false })
			end,
			desc = "Workspace diagnostics",
		},
		{
			"<leader>xf",
			function()
				tb.diagnostics({ bufnr = 0, previewer = false })
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
		{
			"<leader>xt",
			function()
				require("config.diagnostics.todos").open()
			end,
			desc = "Todos (ripgrep)",
		},
	})
end

return M
