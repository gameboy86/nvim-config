return {
	"alexghergh/nvim-tmux-navigation",
	event = "VeryLazy",
	config = function()
		require("config.tmux_navigation").setup()
	end,
}
