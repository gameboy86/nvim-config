local M = {}

local float_diag_grp = vim.api.nvim_create_augroup("float_diagnostic_cursor", { clear = true })
local highlight_grp = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })

function M.attach_float_diagnostics(bufnr)
	vim.api.nvim_clear_autocmds({ group = float_diag_grp, buffer = bufnr })
	vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
		group = float_diag_grp,
		buffer = bufnr,
		callback = function()
			vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
		end,
	})
end

function M.attach_document_highlight(client, bufnr)
	if not client or not client.server_capabilities.documentHighlightProvider then
		return
	end

	vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
		group = highlight_grp,
		buffer = bufnr,
		callback = vim.lsp.buf.document_highlight,
	})

	vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
		group = highlight_grp,
		buffer = bufnr,
		callback = vim.lsp.buf.clear_references,
	})
end

-- wspólny on_attach + możliwość dopięcia dodatkowego per-serwer
function M.make_on_attach(extra)
	return function(client, bufnr)
		M.attach_document_highlight(client, bufnr)
		if extra then
			extra(client, bufnr)
		end
	end
end

function M.capabilities()
	local capa = require("cmp_nvim_lsp").default_capabilities()
	capa.offset_encoding = "utf-16"
	capa.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}
	return capa
end

return M
