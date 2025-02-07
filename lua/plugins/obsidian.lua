return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	ui = {
		enable = false,
	},
	opts = {
		workspaces = {
			{
				name = "personal",
				path = "~/Documents/gameboy"
			},
		},
		templates = {
			folder = "Templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
		},
	},

}
