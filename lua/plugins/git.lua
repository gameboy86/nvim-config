return {
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G" },
		event = "VeryLazy",
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local git = require("config.git")
			git.setup()
			git.keymap()
		end,
	},
	{
		"radyz/telescope-gitsigns",
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
}
