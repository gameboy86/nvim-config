return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = "VeryLazy",
	config = function()
		local tc = require("config.todo-comments")
		tc.setup()
		tc.keymap()
	end,
}
