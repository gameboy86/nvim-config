return {
	"mrjones2014/smart-splits.nvim",
	config = function()
		require("config.smart-splits").setup()
		require("config.smart-splits").keymap()
	end,
}
