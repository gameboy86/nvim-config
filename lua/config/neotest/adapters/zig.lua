local M = {}

local warned = false

local function zig_version()
	local out = vim.fn.systemlist({ "zig", "version" })[1] or ""
	return vim.trim(out)
end

local function supported(version)
	return version:match("^0%.14%.") ~= nil
end

function M.setup()
	local version = zig_version()
	if version == "" or not supported(version) then
		if not warned then
			warned = true
			vim.schedule(function()
				vim.notify(
					("neotest-zig requires Zig 0.14.x, detected %s. Zig adapter disabled."):format(version ~= "" and version or "unknown"),
					vim.log.levels.WARN
				)
			end)
		end
		return nil
	end

	local ok, adapter = pcall(require, "neotest-zig")
	if not ok then
		return nil
	end

	if type(adapter) == "function" then
		adapter = adapter({})
	end

	if type(adapter) ~= "table" then
		return nil
	end

	local orig_is_test_file = adapter.is_test_file
	if type(orig_is_test_file) == "function" then
		adapter.is_test_file = function(file_path)
			local ok_is_test, result = pcall(orig_is_test_file, file_path)
			if not ok_is_test then
				return false
			end
			return result
		end
	end

	return adapter
end

return M
