local M = {}
local neotest = require("neotest")

function M.RunFile()
	neotest.run.run(vim.fn.expand("%"))
end

function M.RunNearest()
	neotest.run.run()
end

function M.RunNearestDap()
	neotest.run.run({ strategy = "dap" })
end

function M.RunFolder()
	neotest.run.run(vim.loop.cwd())
end

function M.ToggleSummary()
	neotest.summary.toggle()
end

function M.ShowOutput()
	neotest.output.open({ enter = true, auto_close = true })
end

function M.ToggleOutput()
	neotest.output_panel.toggle()
end

function M.Stop()
	neotest.run.stop()
end

return M
