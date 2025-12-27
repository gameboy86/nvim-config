-- config/cmp/dap.lua
-- Optional nvim-cmp setup for DAP buffers (e.g. dap-repl).
-- Requires a DAP completion source (cmp-dap).

local M = {}

function M.setup(cmp)
	cmp.setup.filetype({ "dap-repl" }, {
		sources = { { name = "dap" } },
	})
end

return M
