local M = {}

local grp = vim.api.nvim_create_augroup("NvimLint", { clear = true })

function M.attach_autocmd(lint)
	vim.api.nvim_clear_autocmds({ group = grp })

	vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
		group = grp,
		callback = function()
			lint.try_lint()
		end,
	})
end

return M
