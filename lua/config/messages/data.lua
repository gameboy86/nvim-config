-- config/messages/data.lua
-- Responsible for retrieving and shaping Neovim :messages output.

local M = {}

function M.fetch_lines()
	local out = vim.api.nvim_exec2("messages", { output = true }).output
	return vim.split(out, "\n", { trimempty = true })
end

function M.clamp(n, lo, hi)
	return math.max(lo, math.min(n, hi))
end

return M
