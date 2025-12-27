-- config/obsidian/workspaces/second_brain.lua
-- Workspace definition for the "second_brain" vault.

local M = {}

local function month_year()
	return os.date("%m.%Y")
end

function M.workspace()
	return {
		name = "second_brain",
		path = "~/Documents/second_brain",
		overrides = {
			notes_subdir = "0. Inbox",
			templates = {
				folder = "Templates",
				date_format = "%Y-%m-%d",
				time_format = "%H:%M",
				substitutions = {
					my = month_year,
				},
			},
		},
	}
end

return M
