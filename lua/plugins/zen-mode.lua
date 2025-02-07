return {
	{
		"folke/zen-mode.nvim",
		opts = {
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
					}
				},
			},
			on_open = function(win)
			end,
			on_close = function()
			end,
		}
	},
	{
		"folke/twilight.nvim",
		opts = {
			dimming = {
				alpha = 0.25,
				color = { "Normal", "#ffffff" },
				term_bg = "#000000",
				inactive = false,
			},
			context = 10,
			treesitter = true,
			expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
				"function",
				"method",
				"table",
				"if_statement",
			},
			exclude = {},
		}
	}
}
