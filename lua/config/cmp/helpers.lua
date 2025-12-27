-- config/cmp/helpers.lua
-- Shared helper functions for nvim-cmp configuration:
-- - decides when completion is enabled (insert, cmdline, DAP prompt)
-- - snippet expansion function for LuaSnip
-- - shared window border options for completion/documentation popups

local M = {}

function M.enabled()
	local mode = vim.api.nvim_get_mode().mode

	-- Cmdline completion: enable only for ":", "/" and "?" (commands and search).
	if mode == "c" then
		local t = vim.fn.getcmdtype()
		return (t == ":" or t == "/" or t == "?")
	end

	-- DAP uses "prompt" buffers; enable cmp only inside DAP buffers (if cmp-dap is available).
	if vim.bo.buftype == "prompt" then
		local ok, cmp_dap = pcall(require, "cmp_dap")
		return ok and cmp_dap.is_dap_buffer()
	end

	-- Default: enable completion.
	return true
end

function M.snippet_expand(args)
	-- Expand LSP snippets using LuaSnip.
	require("luasnip").lsp_expand(args.body)
end

function M.border_opts()
	-- Shared border + highlight settings used by cmp windows.
	return {
		border = "rounded",
		winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
	}
end

return M
