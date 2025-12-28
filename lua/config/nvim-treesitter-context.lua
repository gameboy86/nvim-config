local M = {}

function M.setup()
	require("treesitter-context").setup({
		max_lines = 2,
		multiline_threshold = 2,
		trim_scope = "inner",
		mode = "cursor",
		separator = "─",
		zindex = 20,
		line_numbers = true,
	})
end

return M
