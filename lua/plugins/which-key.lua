return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = function()
		return require("config.which-key").opts()
	end,
}
