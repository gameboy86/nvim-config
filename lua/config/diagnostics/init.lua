-- config/diagnostics/init.lua
-- Public entry point:
-- - setup(): configures diagnostics visuals
-- - keymap(): registers mappings for diagnostics and TODO picker

local M = {}

function M.setup()
	require("config.diagnostics.settings").setup()
	require("config.diagnostics.highlights").setup()
end

function M.keymap()
	require("config.diagnostics.keymaps").setup()
end

return M
