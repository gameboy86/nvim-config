return {
	"nvim-treesitter/nvim-treesitter-context",
	event = "BufReadPost",
	config = function()
		require("config.nvim-treesitter-context").setup()
	end,
}
