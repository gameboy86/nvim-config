-- config/cmp/init.lua
-- Entry point for completion configuration.
-- Wires together:
-- - snippet loading
-- - cmdline completion
-- - insert-mode completion
-- - DAP completion (optional)

local M = {}

function M.setup()
	local cmp = require("cmp")
	local helpers = require("config.cmp.helpers")

	-- Lazy-load VSCode-style snippets once.
	require("luasnip.loaders.from_vscode").lazy_load()

	require("config.cmp.cmdline").setup(cmp)
	require("config.cmp.insert").setup(cmp, helpers)
	require("config.cmp.dap").setup(cmp)
end

return M
