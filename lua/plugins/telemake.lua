return {
	{
		"ChSotiriou/nvim-telemake",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("config.telemake").setup()
		end,
	},
}
