return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local gits = require("gitsigns")
			gits.setup()
		end,
	},
	-- {
	-- 	"tpope/vim-fugitive",
	-- 	config=function ()
	-- 		vim.keymap.set("n", "<leader>hr", , {})
	-- 	end
	-- },
	-- {
	-- 	"NeogitOrg/neogit",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"sindrets/diffview.nvim",
	-- 		"nvim-telescope/telescope.nvim",
	-- 	},
	-- 	config = true,
	-- },
}
