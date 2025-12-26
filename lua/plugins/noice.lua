return {
	"folke/noice.nvim",
	lazy = false,
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},

	opts = function()
		return require("config.noice").opts()
	end,

	config = function(_, opts)
		require("noice").setup(opts)
		require("config.noice").keymap()
	end,
}
