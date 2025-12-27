-- config/neotest/keymaps.lua
-- Keymaps for neotest. Uses lazy-friendly requires (require only inside callbacks).

local M = {}

local function nt()
	return require("neotest")
end

function M.setup()
	local wk = require("which-key")

	wk.add({
		{ "<leader>t", group = "tests" },

		{
			"<leader>tt",
			function()
				nt().run.run(vim.fn.expand("%"))
			end,
			desc = "Run File",
		},
		{
			"<leader>tr",
			function()
				nt().run.run()
			end,
			desc = "Run Nearest",
		},
		{
			"<leader>tl",
			function()
				nt().run.run_last()
			end,
			desc = "Run Last",
		},

		{
			"<leader>td",
			function()
				nt().run.run({ strategy = "dap" })
			end,
			desc = "Debug Nearest (DAP)",
		},
		{
			"<leader>tD",
			function()
				nt().run.run_last({ strategy = "dap" })
			end,
			desc = "Debug Last (DAP)",
		},

		{
			"<leader>tT",
			function()
				local dir = vim.fn.expand("%:p:h")
				nt().run.run(dir)
			end,
			desc = "Run Folder",
		},

		{
			"<leader>ts",
			function()
				nt().summary.toggle()
			end,
			desc = "Toggle Summary",
		},
		{
			"<leader>to",
			function()
				nt().output.open({ enter = true })
			end,
			desc = "Show Output",
		},
		{
			"<leader>tO",
			function()
				nt().output_panel.toggle()
			end,
			desc = "Toggle Output Panel",
		},

		{
			"<leader>tS",
			function()
				nt().run.stop()
			end,
			desc = "Stop",
		},
	})
end

return M
