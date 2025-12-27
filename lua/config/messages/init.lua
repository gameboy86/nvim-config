-- config/messages/init.lua
-- Public module API for :messages helpers.

local M = {}

function M.keymap()
	require("config.messages.keymaps").setup()
end

-- Optional convenience exports
function M.open_split(cursorline)
	local data = require("config.messages.data")
	require("config.messages.split").open(data.fetch_lines(), cursorline)
end

function M.open_telescope()
	require("config.messages.telescope").open()
end

return M
