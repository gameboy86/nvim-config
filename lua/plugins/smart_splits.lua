return {
	"mrjones2014/smart-splits.nvim",
	config = function()
		local builtin = require("smart-splits")
		vim.keymap.set("n", "<c-h>", builtin.move_cursor_left, {})
		vim.keymap.set("n", "<c-l>", builtin.move_cursor_right, {})
		vim.keymap.set("n", "<c-k>", builtin.move_cursor_up, {})
		vim.keymap.set("n", "<c-j>", builtin.move_cursor_down, {})
	end,
}
