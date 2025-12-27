local M = {}

function M.zen_opts()
	return {
		window = {
			backdrop = 0.95,
			width = 120,
			height = 1,
			options = {},
		},
		plugins = {
			options = {
				enabled = true,
				ruler = false,
				showcmd = false,
				laststatus = 0,
			},
			twilight = { enabled = true },
			gitsigns = { enabled = false },
			tmux = { enabled = false },
			todo = { enabled = false },
			alacritty = {
				enabled = false,
				font = "14",
			},
			neovide = {
				enabled = false,
				scale = 1.2,
				disable_animations = {
					neovide_animation_length = 0,
					neovide_cursor_animate_command_line = false,
					neovide_scroll_animation_length = 0,
					neovide_position_animation_length = 0,
					neovide_cursor_animation_length = 0,
					neovide_cursor_vfx_mode = "",
				},
			},
		},
		on_open = function(_win) end,
		on_close = function() end,
	}
end

function M.twilight_opts()
	return {
		dimming = {
			alpha = 0.25,
			color = { "Normal", "#ffffff" },
			term_bg = "#000000",
			inactive = false,
		},
		context = 20,
		treesitter = true,
		expand = {
			"function",
			"method",
			"table",
			"if_statement",
		},
		exclude = {},
	}
end

function M.keymap()
	local wk = require("which-key")

	wk.add({
		{ "<leader>z", group = "folds_zen" },
		{ "<leader>zz", "<cmd>ZenMode<CR>", desc = "ZenMode" },
		{ "<leader>zt", "<cmd>Twilight<CR>", desc = "Toggle Twilight" },
	})
end

return M
