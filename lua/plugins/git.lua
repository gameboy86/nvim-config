return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local gits = require("gitsigns")
			gits.setup()

			vim.keymap.set("n", "]g", gits.next_hunk, {})
			vim.keymap.set("n", "[g", gits.prev_hunk, {})

			vim.keymap.set("n", "<leader>gl", gits.blame_line, {})
			vim.keymap.set("n", "<leader>gL", function()
				gits.blame_line({ full = true })
			end, {})
			vim.keymap.set("n", "<leader>gp", gits.preview_hunk, {})
			vim.keymap.set("n", "<leader>gh", gits.reset_hunk, {})
			vim.keymap.set("n", "<leader>gr", gits.reset_buffer, {})
			vim.keymap.set("n", "<leader>gs", gits.stage_hunk, {})
			vim.keymap.set("n", "<leader>gS", gits.stage_buffer, {})
			vim.keymap.set("n", "<leader>gu", gits.undo_stage_hunk, {})
			vim.keymap.set("n", "<leader>gd", gits.diffthis, {})
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
