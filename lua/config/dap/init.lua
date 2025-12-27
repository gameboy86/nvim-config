local M = {}

function M.setup()
	require("config.dap.ui").setup()
	require("config.dap.go").setup()
	require("config.dap.keymaps").setup()
	require("nvim-dap-virtual-text").setup()
end

return M
