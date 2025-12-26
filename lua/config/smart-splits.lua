local M = {}

function M.setup()
	return {}
end

function M.keymap()
	local ssplit = require("smart-splits")
	local wk = require("which-key")
	wk.add({
		{ "<C-Up>", ssplit.resize_up, desc = "Resize split up", mode = "n" },
		{ "<C-Down>", ssplit.resize_down, desc = "Resize split down", mode = "n" },
		{ "<C-Left>", ssplit.resize_left, desc = "Resize split left", mode = "n" },
		{ "<C-Right>", ssplit.resize_right, desc = "Resize split right", mode = "n" },
	})
end

return M
