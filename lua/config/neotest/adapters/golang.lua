-- config/neotest/adapters/golang.lua
-- neotest-golang adapter configuration.

local M = {}

function M.cgo_enabled()
	local out = vim.fn.systemlist({ "go", "env", "CGO_ENABLED" })[1]
	return out == "1"
end

function M.test_args()
	-- Add -race only when CGO is actually enabled in the current Neovim environment.
	local args = { "-v", "-count=1" }
	if M.cgo_enabled() then
		table.insert(args, 2, "-race")
	end
	return args
end

function M.setup()
	return require("neotest-golang")({
		dap_mode = "dap-go",
		dap_go_opts = {},
		runner = "gotestsum",
		go_test_args = M.test_args,
		env = { CGO_ENABLED = "1" },
	})
end

return M
