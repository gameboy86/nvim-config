return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	opts = function()
		return require("config.conform").opts()
	end,
}
