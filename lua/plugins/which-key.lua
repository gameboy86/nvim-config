return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		require("config.which_key").init()
	end,
	opts = function()
		return require("config.which_key").opts()
	end,
}
