return {
	"johnfrankmorgan/whitespace.nvim",
	config = function()
		require("whitespace-nvim").setup({
			highlight = "TabLineFill",
			ignored_filetypes = { "TelescopePrompt", "Trouble", "help" },
			ignore_terminal = true,
			return_cursor = true,
		})
	end,
}
