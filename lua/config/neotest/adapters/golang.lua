local M = {}

local function go_env(name)
	local out = vim.fn.systemlist({ "go", "env", name })[1] or ""
	return vim.fs.normalize(out)
end

local function starts_with(path, prefix)
	if not path or path == "" or not prefix or prefix == "" then
		return false
	end
	path = vim.fs.normalize(path)
	prefix = vim.fs.normalize(prefix)
	return vim.startswith(path, prefix .. "/") or path == prefix
end

function M.cgo_enabled()
	local out = vim.fn.systemlist({ "go", "env", "CGO_ENABLED" })[1]
	return out == "1"
end

function M.test_args()
	local args = { "-v", "-count=1" }
	if M.cgo_enabled() then
		table.insert(args, 2, "-race")
	end
	return args
end

function M.setup()
	local gomodcache = go_env("GOMODCACHE")
	local goroot_src = go_env("GOROOT") .. "/src" -- np. /usr/lib/go/src

	local function is_external_go_path(file_path)
		file_path = vim.fs.normalize(file_path)
		return starts_with(file_path, gomodcache) or starts_with(file_path, goroot_src)
	end

	local adapter = require("neotest-golang")({
		dap_mode = "dap-go",
		dap_go_opts = {},
		runner = "gotestsum",
		go_test_args = M.test_args,
		env = { CGO_ENABLED = "1" },
	})

	local orig_is_test_file = adapter.is_test_file
	adapter.is_test_file = function(file_path)
		if is_external_go_path(file_path) then
			return false
		end
		return orig_is_test_file(file_path)
	end

	return adapter
end

return M
