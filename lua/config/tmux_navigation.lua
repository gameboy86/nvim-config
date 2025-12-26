local M = {}

function M.setup()
	local nvim_tmux_nav = require("nvim-tmux-navigation")

	nvim_tmux_nav.setup({
		disable_when_zoomed = true,
	})
end

function M.keymap()
	local wk = require("which-key")
	local nvim_tmux_nav = require("nvim-tmux-navigation")

	wk.add({
		{ "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft, desc = "Move cursor left", mode = "n" },
		{ "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight, desc = "Move cursor right", mode = "n" },
		{ "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp, desc = "Move cursor up", mode = "n" },
		{ "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown, desc = "Move cursor down", mode = "n" },
	})
end

return M
