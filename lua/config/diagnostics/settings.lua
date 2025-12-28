-- config/diagnostics/settings.lua
-- Central place for configuring Neovim diagnostics UI:
-- - underline, virtual text, sorting
-- - custom gutter signs for each severity level

local M = {}

function M.setup()
	-- Whole-line highlights
	vim.api.nvim_set_hl(0, "DiagnosticLineError", { bg = "#2a1f2a" })
	vim.api.nvim_set_hl(0, "DiagnosticLineWarn", { bg = "#2a261a" }) -- przykładowe tło pod WARN

	-- Underlines (use sp + underline)
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { underline = true, undercurl = false, sp = "#db4b4b" })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { underline = true, undercurl = false, sp = "#e0af68" })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { underline = true, undercurl = false, sp = "#0db9d7" })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { underline = true, undercurl = false, sp = "#10b981" })

	vim.diagnostic.config({
		underline = true,
		virtual_text = false,
		update_in_insert = true,
		severity_sort = true,
		float = { border = "rounded" },
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = " ",
				[vim.diagnostic.severity.WARN] = " ",
				[vim.diagnostic.severity.HINT] = " ",
				[vim.diagnostic.severity.INFO] = " ",
			},
			linehl = {
				[vim.diagnostic.severity.ERROR] = "DiagnosticLineError",
				[vim.diagnostic.severity.WARN] = "DiagnosticLineWarn",
			},
		},
	})
end

return M
