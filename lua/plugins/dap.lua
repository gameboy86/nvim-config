return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
			{
				"igorlfs/nvim-dap-view",
				opts = {
					auto_toggle = true,
					help = { border = "rounded" },
				},
			},
		},
		config = function()
			local dap = require("config.dap.init")
			dap.setup()
		end,
	},
}
