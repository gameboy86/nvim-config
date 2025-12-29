return {
	{
		"stevearc/overseer.nvim",
		opts = {},
		config = function(_, opts)
			require("config.overseer").setup(opts)
			require("config.overseer").keymap()
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
	},
}
