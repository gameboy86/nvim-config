local M = {}

function M.opts()
	return {
		filter = function(key_binding)
			return key_binding ~= nil and key_binding ~= ""
		end,
	}
end

function M.init()
	vim.o.timeout = true
	vim.o.timeoutlen = 500
end

return M
