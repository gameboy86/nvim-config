return {
	"kevinhwang91/nvim-ufo",
	lazy = false, -- ✅ najważniejsze
	dependencies = { "kevinhwang91/promise-async" },
	opts = function()
		return require("config.ufo").opts()
	end,
	config = function(_, opts)
		require("ufo").setup(opts)
	end,
}
