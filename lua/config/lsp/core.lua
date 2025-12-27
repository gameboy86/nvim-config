local M = {}

function M.make_on_attach(extra)
	return function(client, bufnr)
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
