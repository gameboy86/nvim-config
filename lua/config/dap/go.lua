local M = {}

local function choose_program()
	local default = vim.fn.getcwd() .. "/cmd/"
	local path = vim.fn.input("Go program dir/file: ", default, "file")
	if not path or path == "" then
		return default
	end
	return path
end

function M.setup()
	require("dap-go").setup({
		dap_configurations = {
			{
				type = "go",
				name = "Debug (launch) - choose program",
				request = "launch",
				program = choose_program,
				cwd = "${workspaceFolder}",
				outputMode = "remote",
			},
		},
	})
end

return M
