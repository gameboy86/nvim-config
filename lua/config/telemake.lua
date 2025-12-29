local M = {}

function M.setup()
	require("telescope").load_extension("telemake")

	vim.keymap.set("n", "<leader>fm", "<cmd>Telescope telemake<cr>", {
		desc = "Makefile targets (telemake)",
		silent = true,
	})
end

return M
