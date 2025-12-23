local M = {}

function M.setup()
	---@type opencode.Opts
	vim.g.opencode_opts = {
		-- zostaw puste albo uzupełniaj w przyszłości
	}
	vim.o.autoread = true
end

return M
