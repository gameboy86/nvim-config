local M = {}

function M.setup()
	local neotest = require("neotest")

	neotest.setup({
		adapters = {
			require("neotest-golang")({
				dap_mode = "dap-go",
				dap_go_opts = {},
				runner = "gotestsum",
			}),

			require("neotest-python")({
				dap = { justMyCode = false },
				runner = "pytest",
				python = ".venv/bin/python",
			}),
		},
	})
end

function M.keymap()
	local wk = require("which-key")
	local neotest = require("neotest")

	wk.add({
		{ "<leader>t", group = "tasks + neotest" },

		{
			"<leader>tt",
			function()
				neotest.run.run(vim.fn.expand("%"))
			end,
			desc = "Run File",
		},
		{
			"<leader>tr",
			function()
				neotest.run.run()
			end,
			desc = "Run Nearest",
		},
		{
			"<leader>tl",
			function()
				neotest.run.run_last()
			end,
			desc = "Run Last",
		},

		{
			"<leader>td",
			function()
				neotest.run.run({ strategy = "dap" })
			end,
			desc = "Debug Nearest (DAP)",
		},
		{
			"<leader>tD",
			function()
				neotest.run.run_last({ strategy = "dap" })
			end,
			desc = "Debug Last (DAP)",
		},

		{
			"<leader>tT",
			function()
				local dir = vim.fn.expand("%:p:h")
				neotest.run.run(dir)
			end,
			desc = "Run Folder",
		},

		{
			"<leader>ts",
			function()
				neotest.summary.toggle()
			end,
			desc = "Toggle Summary",
		},
		{
			"<leader>to",
			function()
				neotest.output.open({ enter = true })
			end,
			desc = "Show Output",
		},
		{
			"<leader>tO",
			function()
				neotest.output_panel.toggle()
			end,
			desc = "Toggle Output Panel",
		},

		{
			"<leader>tS",
			function()
				neotest.run.stop()
			end,
			desc = "Stop",
		},
	})
end

return M
