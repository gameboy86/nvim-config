local M = {}

function M.opts()
	return {
		options = {
			theme = "auto",
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = {
				{
					"filename",
					file_status = true,
					path = 1, -- 0=filename, 1=relative, 2=absolute
				},
			},
			lualine_x = { "encoding", "fileformat", "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
	}
end

return M
