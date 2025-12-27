local M = {}

function M.setup()
	local wk = require("which-key")
	local tb = require("telescope.builtin")

	wk.add({
		{ "<leader>l", group = "lsp" },
		{ "<leader>lk", vim.lsp.buf.hover, desc = "Hover symbol details" },
		{ "<leader>la", vim.lsp.buf.code_action, desc = "LSP code action" },
		{ "<leader>lf", vim.lsp.buf.format, desc = "Format code" },
		{ "<leader>lr", vim.lsp.buf.rename, desc = "Rename current symbol" },
		{ "<leader>lh", vim.lsp.buf.signature_help, desc = "Signature help" },
		{ "<leader>ld", tb.lsp_definitions, desc = "Definition" },
		{ "<leader>lR", tb.lsp_references, desc = "References" },
		{ "<leader>li", tb.lsp_implementations, desc = "Implementations" },
		{ "<leader>ly", tb.lsp_type_definitions, desc = "Type definitions" },
	})
end

return M
