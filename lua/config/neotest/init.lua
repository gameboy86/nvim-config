-- config/neotest/init.lua
-- Entry point for neotest: registers adapters and (optionally) keymaps.

local M = {}

function M.setup()
	require("config.neotest.ui").setup()
	local neotest = require("neotest")

	neotest.setup({
		adapters = {
			require("config.neotest.adapters.golang").setup(),
			require("config.neotest.adapters.python").setup(),
		},
	})
end

function M.keymap()
	require("config.neotest.keymaps").setup()
end

return M
