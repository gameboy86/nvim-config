local M = {}

function M.setup()
	local lint = require("lint")
	local core = require("config.lint.core")
	local linters = require("config.lint.linters")

	lint.linters_by_ft = linters.by_ft()
	core.attach_autocmd(lint)
end

return M
