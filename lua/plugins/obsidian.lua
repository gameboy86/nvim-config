return {
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		ft = "markdown",
		dependencies = { "nvim-lua/plenary.nvim" },

		opts = function()
			return require("config.obsidian").opts()
		end,

		-- Only register which-key group early (no mappings here).
		init = function()
			require("config.obsidian").keymap()
		end,

		-- Actual mappings + lazy-loading trigger (single source of truth).
		keys = function()
			return require("config.obsidian.keymaps").keys()
		end,

		config = function(_, opts)
			require("obsidian").setup(opts)
		end,
	},
}
