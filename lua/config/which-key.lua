local M = {}

function M.opts()
	return {
		filter = function(key_binding)
			return key_binding ~= nil and key_binding ~= ""
		end,
	}
end

return M
