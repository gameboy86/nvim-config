return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local gits = require("gitsigns")
			gits.setup()
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
