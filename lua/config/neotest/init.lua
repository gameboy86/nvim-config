-- config/neotest/init.lua
-- Entry point for neotest: registers adapters and (optionally) keymaps.

local M = {}

function M.setup()
	require("config.neotest.ui").setup()
	local neotest = require("neotest")
	local adapters = {
		require("config.neotest.adapters.golang").setup(),
		require("config.neotest.adapters.python").setup(),
		require("config.neotest.adapters.zig").setup(),
	}

	adapters = vim.tbl_filter(function(adapter)
		return adapter ~= nil
	end, adapters)

	neotest.setup({
		adapters = adapters,
		floating = {
			border = "rounded",
		},
		watch = {
			symbol_queries = {
				zig = [[
					; query
					(identifier) @symbol
				]],
			},
		},
	})
end

function M.keymap()
	require("config.neotest.keymaps").setup()
end

return M
