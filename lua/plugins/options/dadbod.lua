local M = {}

local function db_completition()
	require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
end

function M.setup()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = {
			"sql",
		},
		command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
	})
	vim.api.nvim_create_autocmd("FileType", {
		pattern = {
			"sql",
			"mysql",
			"plsql",
		},
		callback = function()
			vim.schedule(db_completition)
		end,
	})
end

return M
