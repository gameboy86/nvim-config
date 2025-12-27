-- config/obsidian/keymaps.lua
-- Single source of truth for Obsidian keybindings:
-- - M.keys() is used by lazy.nvim to create mappings and lazy-load the plugin
-- - M.which_key_group() registers only the group name in which-key (no duplicate mappings)

local M = {}

function M.keys()
	return {
		{ "<leader>of", "<cmd>ObsidianFollowLink<CR>", desc = "Follow link" },
		{ "<leader>oc", "<cmd>ObsidianNew<CR>", desc = "Create note" },
		{ "<leader>od", "<cmd>ObsidianToggleCheckbox<CR>", desc = "Toggle checkbox" },
	}
end

function M.which_key_group()
	local wk = require("which-key")
	wk.add({
		{ "<leader>o", group = "obsidian" },
	})
end

return M
