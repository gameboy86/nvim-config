return {
	"johnfrankmorgan/whitespace.nvim",
	event = "BufReadPre",
	config = function()
		require("config.whitespace").setup()
	end,
}
