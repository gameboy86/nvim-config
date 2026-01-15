local M = {}

local function choose_main_file()
	local default_dir = vim.fn.getcwd() .. "/"
	local dir = vim.fn.input("Zig dir: ", default_dir, "dir")
	if not dir or dir == "" then
		dir = default_dir
	end
	dir = dir:gsub("/+$", "")

	local default_file = dir .. "/main.zig"
	local file = vim.fn.input("Zig main file: ", default_file, "file")
	if not file or file == "" then
		file = default_file
	end
	return file
end

local function choose_args()
	local input = vim.fn.input("Program args (space-separated): ")
	if not input or input == "" then
		return {}
	end
	return vim.split(input, "%s+")
end

function M.setup()
	local dap = require("dap")

	dap.adapters.codelldb = {
		type = "executable",
		command = "codelldb",
	}

	dap.configurations.zig = {
		{
			type = "codelldb",
			name = "Zig: zig run (choose main file)",
			request = "launch",
			program = function()
				local zig = vim.fn.exepath("zig")
				if zig == nil or zig == "" then
					error("`zig` not found in PATH (Neovim)")
				end
				return zig
			end,

			args = function()
				local main_file = choose_main_file()
				local prog_args = choose_args()

				local a = { "run", main_file }

				if #prog_args > 0 then
					table.insert(a, "--")
					for _, v in ipairs(prog_args) do
						table.insert(a, v)
					end
				end

				return a
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,

			-- TO DODAJ:
			initCommands = {
				"settings set target.process.stop-on-exec false",
			},
		},
	}
end
return M
