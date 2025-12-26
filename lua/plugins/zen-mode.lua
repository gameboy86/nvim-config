return {
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = function()
			return require("config.zen_mode").zen_opts()
		end,
		init = function()
			require("config.zen_mode").keymap()
		end,
		config = function(_, opts)
			require("zen-mode").setup(opts)
		end,
	},
	{
		"folke/twilight.nvim",
		cmd = "Twilight",
		opts = function()
			return require("config.zen_mode").twilight_opts()
		end,
		config = function(_, opts)
			require("twilight").setup(opts)
		end,
	},
}
