return {
	"kevinhwang91/nvim-ufo",
	lazy = false,
	dependencies = { "kevinhwang91/promise-async" },
	opts = function()
		return require("config.ufo").opts()
	end,
	config = function(_, opts)
		require("ufo").setup(opts)
		return require("config.ufo").keymap()
	end,
}
