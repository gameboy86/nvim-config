return {
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = function()
			return require("config.zen_mode").zen_opts()
		end,
	},
	{
		"folke/twilight.nvim",
		cmd = "Twilight",
		opts = function()
			return require("config.zen_mode").twilight_opts()
		end,
	},
}
