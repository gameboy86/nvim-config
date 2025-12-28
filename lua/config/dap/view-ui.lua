local M = {}

function M.setup()
	require("dap-view").setup({
		auto_toggle = true,
		help = { border = "rounded" },
	})

	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "dap-view", "dap-view-term", "dap-repl" },
		callback = function()
			vim.wo.winhighlight = "Normal:NormalFloat,NormalNC:NormalFloat,WinSeparator:FloatBorder"
			vim.wo.wrap = true
		end,
	})
end

return M
