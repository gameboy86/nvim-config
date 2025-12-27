local M = {}

function M.setup()
	vim.api.nvim_create_autocmd("VimLeavePre", {
		callback = function()
			-- Cleanup hook: before Neovim exits, delete any leftover temporary debug binaries
			-- matching "__debug_bin*". Some debuggers / build tools create these artifacts and
			-- they can clutter the project directory if not removed.
			--
			-- We notify on success and warn on failure (e.g. file missing / permission issues).
			for _, file in ipairs(vim.fn.glob("__debug_bin*", true, true)) do
				local ok, err = os.remove(file)
				if ok then
					vim.notify("Delete: " .. file)
				else
					vim.notify("Delete error " .. file .. ": " .. err, vim.log.levels.WARN)
				end
			end
		end,
	})

	vim.api.nvim_create_autocmd("ColorScheme", {
		callback = function()
			-- Force plain underlines for diagnostics after applying a colorscheme.
			-- Some colorschemes (and tmux/terminal setups) render diagnostic underlines as "undercurl",
			-- which may be unsupported or invisible. This ensures errors/warnings/etc. are always visible.
			for _, s in ipairs({ "Error", "Warn", "Info", "Hint" }) do
				vim.api.nvim_set_hl(0, "DiagnosticUnderline" .. s, { underline = true })
			end
		end,
	})

	vim.api.nvim_create_autocmd("BufWritePre", {
		callback = function(args)
			-- Strip trailing whitespace on save for all filetypes except Markdown.
			-- Markdown often uses trailing spaces intentionally (e.g. hard line breaks).
			-- We save/restore the window view so the substitution won't move the cursor or scroll position.
			local ft = vim.bo[args.buf].filetype
			if ft == "markdown" then
				return
			end
			local view = vim.fn.winsaveview()
			vim.cmd([[%s/\s\+$//e]])
			vim.fn.winrestview(view)
		end,
	})
end

return M
