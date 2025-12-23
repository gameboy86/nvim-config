return {
	"kevinhwang91/nvim-ufo",
	event = "BufReadPre",
	dependencies = { "kevinhwang91/promise-async" },
	opts = function()
		return require("config.ufo").opts()
	end,
}
