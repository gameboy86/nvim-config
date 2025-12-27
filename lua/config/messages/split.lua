-- config/messages/split.lua
-- Split-based UI for viewing :messages in a scratch buffer.
-- Provides a close mapping ('q') and keeps cursor position stable.

local M = {}

local data = require("config.messages.data")

function M.open(lines, cursorline)
	lines = lines or data.fetch_lines()

	vim.cmd("botright new")
	local buf = vim.api.nvim_get_current_buf()

	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].swapfile = false
	vim.bo[buf].modifiable = true
	vim.bo[buf].filetype = "messages"
	vim.bo[buf].buflisted = false

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.bo[buf].modifiable = false

	vim.keymap.set("n", "q", "<cmd>close<cr>", {
		buffer = buf,
		silent = true,
		nowait = true,
		desc = "Close messages window",
	})

	local lnum = cursorline or #lines
	lnum = data.clamp(lnum, 1, math.max(#lines, 1))
	vim.api.nvim_win_set_cursor(0, { lnum, 0 })
end

return M
