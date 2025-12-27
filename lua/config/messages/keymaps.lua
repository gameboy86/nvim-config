-- config/messages/keymaps.lua
-- Registers which-key group + mappings for messages UIs.

local M = {}

function M.setup()
	local wk = require("which-key")
	local split = require("config.messages.split")
	local telescope_ui = require("config.messages.telescope")
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

		{
			"<leader>mm",
			function()
				telescope_ui.open()
			end,
			desc = "Open :messages (Telescope)",
		},
	})
end

return M
