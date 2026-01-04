return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	opts = function()
		return require("config.conform").opts()
	end,
	config = function(_, opts)
		require("conform").setup(opts)
		require("config.conform").init()
	end,
}
