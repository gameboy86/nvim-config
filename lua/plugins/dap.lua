return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"leoluz/nvim-dap-go",
		"nvim-neotest/nvim-nio",
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		-- require("nvim-dap-virtual-text").setup()
		require("dap-go").setup({
			dap_configurations = {
				{
					type = "go",
					name = "Attach to Delve",
					mode = "remote",
					request = "attach",
					port = 2345,
					host = "127.0.0.1"
				},
			}
		})
		local config = require("plugins/options/dap")
		config.setup()
		require("dapui").setup({
			icons = config.configuration.dapui.icons,
			mappings = config.configuration.dapui.mappings,
			layouts = config.configuration.dapui.layouts,
			floating = config.configuration.dapui.floating,
			windows = config.configuration.dapui.windows,
			render = config.configuration.dapui.render,
		})
		local dap, dapui = require("dap"), require("dapui")
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
		require("dap.ext.vscode").load_launchjs(nil)
	end,
}
