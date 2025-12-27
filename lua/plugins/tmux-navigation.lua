return {
	"alexghergh/nvim-tmux-navigation",
	event = "VeryLazy",
	config = function()
		require("config.tmux-navigation").setup()
		require("config.tmux-navigation").keymap()
	end,
}
