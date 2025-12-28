return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
			{
				"igorlfs/nvim-dap-view",
				config = function()
					require("config.dap.view-ui").setup()
				end,
			},
		},
		config = function()
			local dap = require("config.dap.init")
			dap.setup()
		end,
	},
}
