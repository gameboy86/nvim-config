return {
	{
		"hedyhli/outline.nvim",
		config = function()
			local options = require("plugins/options/outline")
			require("outline").setup({
				preview_window = options.preview_window,
			})
		end,
	},
}
