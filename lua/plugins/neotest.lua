return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"vim-test/vim-test",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		-- "nvim-neotest/neotest-go",
		"fredrikaverpil/neotest-golang",
		"nvim-neotest/neotest-python",
		"nvim-neotest/neotest-plenary",
		"nvim-neotest/neotest-vim-test",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-python")({
					dap = { justMyCode = false },
				}),
				require("neotest-plenary"),
				require("neotest-vim-test")({
					ignore_file_types = { "python", "vim", "lua" },
				}),
				require("neotest-golang"),
			},
			log_level = 1,
			diagnostic = {
				enabled = true,
				severity = 1,
			},
			consumers = {
				overseer = require("neotest.consumers.overseer"),
			},
			overseer = {
				enabled = true,
				force_default = true,
			},
		})
	end,
}
