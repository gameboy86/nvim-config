return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			file_types = { "markdown" },
		},
		ft = { "markdown" },
	},

	{
		"iamcco/markdown-preview.nvim",
		cmd = {
			"MarkdownPreviewToggle",
			"MarkdownPreview",
			"MarkdownPreviewStop",
		},
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
}
