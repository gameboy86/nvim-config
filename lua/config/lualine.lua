local M = {}

function M.opts()
	return {
		options = {
			theme = "auto",
			-- jeśli nie chcesz globalnego statusline "na górze":
			-- globalstatus = false,
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
			lualine_x = { "encoding", "fileformat", "filetype", "overseer" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
	}
end

return M
