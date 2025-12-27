-- config/neotest/ui.lua
-- UI niceties for neotest buffers (output/summary/panels):
-- - "q" closes the window
-- - buffers are not listed and are wiped when hidden

local M = {}

function M.setup()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = {
			"neotest-output",
			"neotest-summary",
			"neotest-output-panel",
		},
		callback = function(ev)
			-- Make it behave like a temporary UI buffer
			vim.bo[ev.buf].buflisted = false
			vim.bo[ev.buf].swapfile = false
			vim.bo[ev.buf].bufhidden = "wipe"

			-- Close with 'q'
			vim.keymap.set("n", "q", "<cmd>close<CR>", {
				buffer = ev.buf,
				silent = true,
				nowait = true,
				desc = "Close neotest window",
			})
		end,
	})
end

return M
