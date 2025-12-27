-- config/obsidian/init.lua
-- Main obsidian.nvim configuration:
-- - collects workspace definitions from separate files
-- - configures completion and note frontmatter
-- - exposes opts() and keymap() for your lazy.nvim plugin spec

local M = {}

function M.workspaces()
	return {
		require("config.obsidian.workspaces.personal").workspace(),
	}
end

function M.opts()
	local fm = require("config.obsidian.frontmatter")

	return {
		ui = { enable = false },
		completion = {
			nvim_cmp = true,
			min_chars = 2,
		},
		workspaces = M.workspaces(),
		new_notes_location = "notes_subdir",
		prepend_note_id = true,
		note_frontmatter_func = fm.note_frontmatter,
	}
end

function M.keymap()
	require("config.obsidian.keymaps").which_key_group()
end

return M
