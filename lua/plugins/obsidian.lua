return {
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = true,
		ft = "markdown",
		dependencies = { "nvim-lua/plenary.nvim" },

		opts = function()
			return require("config.obsidian").opts()
		end,

		init = function()
			require("config.obsidian").keymap()
		end,

		config = function(_, opts)
			require("obsidian").setup(opts)
		end,
	},
}
