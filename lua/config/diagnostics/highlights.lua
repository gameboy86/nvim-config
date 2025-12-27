local M = {}

local function set_msg_area_hl()
	vim.api.nvim_set_hl(0, "MsgArea", { bg = "#2b2140" })
	vim.api.nvim_set_hl(0, "MsgSeparator", { bg = "#2b2140" })
	vim.api.nvim_set_hl(0, "ModeMsg", { bg = "#2b2140" })
	vim.api.nvim_set_hl(0, "Cmdline", { bg = "#2b2140" })
end

function M.setup()
	set_msg_area_hl()

	vim.api.nvim_create_autocmd("ColorScheme", {
		callback = set_msg_area_hl,
	})
end

return M
