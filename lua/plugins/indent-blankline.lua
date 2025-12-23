return {
	{ "HiPhish/rainbow-delimiters.nvim" },
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = "BufReadPre",
		config = function()
			require("config.indent_blankline").setup()
		end,
	},
}
