return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"leoluz/nvim-dap-go",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
		{
			"igorlfs/nvim-dap-view",
			opts = { auto_toggle = true },
		},
	},
	config = function()
		require("config.dap_ui").setup()
		require("config.dap_go").setup()
	end,
}
