-- config/neotest/adapters/python.lua
-- neotest-python adapter configuration.

local M = {}

function M.bin()
	-- Prefer project venv if present; otherwise fallback to system python3.
	local venv = vim.fn.getcwd() .. "/.venv/bin/python"
	if vim.fn.filereadable(venv) == 1 then
		return venv
	end
	return "python3"
end

function M.setup()
	return require("neotest-python")({
		dap = { justMyCode = false },
		runner = "pytest",
		python = M.bin(),
	})
end

return M
