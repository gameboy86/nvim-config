local M = {}

function M.setup()
	local highlight = {
		"RainbowYellow",
		"RainbowBlue",
		"RainbowOrange",
		"RainbowGreen",
		"RainbowViolet",
		"RainbowCyan",
		"Function",
		"Label",
	}

	local hooks = require("ibl.hooks")

	hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
		vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#e0af68", bold = true, nocombine = true }) -- yellow
		vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#7aa2f7", bold = true, nocombine = true }) -- blue
		vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#ff9e64", bold = true, nocombine = true }) -- orange
		vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#9ece6a", bold = true, nocombine = true }) -- green
		vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#bb9af7", bold = true, nocombine = true }) -- purple
		vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#7dcfff", bold = true, nocombine = true }) -- cyan
	end)
	vim.g.rainbow_delimiters = { highlight = highlight }

	require("ibl").setup({
		scope = {
			highlight = highlight,
			show_end = false,
			show_start = false,
		},
	})

	hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
end

return M
