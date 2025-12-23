local M = {}

function M.setup()
	local lint = require("lint")

	lint.linters_by_ft = {
		go = { "golangcilint" },
		python = { "ruff" },
	}

	local grp = vim.api.nvim_create_augroup("NvimLint", { clear = true })

	vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
		group = grp,
		callback = function()
			lint.try_lint()
		end,
	})
end

return M
