-- config/messages/keymaps.lua
-- Registers which-key group + mappings for messages UIs.

local M = {}

function M.setup()
	local wk = require("which-key")
	local split = require("config.messages.split")
	local data = require("config.messages.data")

	wk.add({
		{ "<leader>m", group = "messages" },

		{
			"<leader>mM",
			function()
				split.open(data.fetch_lines())
			end,
			desc = "Open :messages (split)",
		},
	})
end

return M
