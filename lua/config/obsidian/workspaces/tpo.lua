local M = {}

function M.workspace()
	return {
		name = "PKS",
		path = vim.fn.expand("~/PKS"),
		overrides = {
			notes_subdir = "inbox",
			templates = {
				folder = "shared/templates",
				date_format = "%Y-%m-%d",
				time_format = "%H:%M",
			},
		},
	}
end

return M
