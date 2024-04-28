return {
	"nvim-focus/focus.nvim",
	config = function()
		require("focus").setup({
			autoresize = {
				-- enable = true, -- Enable or disable auto-resizing of splits
				width = 120, -- Force width for the focused window
				-- height = 0, -- Force height for the focused window
				minwidth = 10, -- Force minimum width for the unfocused window
				minheight = 10, -- Force minimum height for the unfocused window
				-- height_quickfix = 10, -- Set the height of quickfix panel
			},
		})
		local ignore_filetypes = { "neo-tree" }
		local ignore_buftypes = { "nofile", "prompt", "popup" }

		local augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })

		vim.api.nvim_create_autocmd("WinEnter", {
			group = augroup,
			callback = function(_)
				if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
					vim.w.focus_disable = true
				else
					vim.w.focus_disable = false
				end
			end,
			desc = "Disable focus autoresize for BufType",
		})

		vim.api.nvim_create_autocmd("FileType", {
			group = augroup,
			callback = function(_)
				if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
					vim.b.focus_disable = true
				else
					vim.b.focus_disable = false
				end
			end,
			desc = "Disable focus autoresize for FileType",
		})
	end,
}
