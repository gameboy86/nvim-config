-- lua/plugins/opencode.lua
return {
	"NickvanDyke/opencode.nvim",
	event = "VeryLazy",
	dependencies = {
		{
			"folke/snacks.nvim",
			opts = {
				input = {},
				picker = {},
				terminal = {},
			},
		},
	},
	config = function()
		require("config.opencode").setup()
	end,
}
