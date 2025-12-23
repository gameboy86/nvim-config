return {
	"stevearc/overseer.nvim",
	event = "VeryLazy",
	opts = function()
		return require("config.overseer").opts()
	end,
}
