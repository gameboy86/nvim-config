local M = {}

local float_diag_grp = vim.api.nvim_create_augroup("float_diagnostic_cursor", { clear = true })
local highlight_grp = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })

local function attach_float_diagnostics(bufnr)
	vim.api.nvim_clear_autocmds({ group = float_diag_grp, buffer = bufnr })
	vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
		group = float_diag_grp,
		buffer = bufnr,
		callback = function()
			vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
		end,
	})
end

local function attach_document_highlight(client, bufnr)
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

-- jeden wspólny on_attach, a per-serwer możesz go rozszerzać
local function make_on_attach(extra)
	return function(client, bufnr)
		attach_document_highlight(client, bufnr)
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

function M.setup_servers()
	local capa = M.capabilities()

	-- Lua
	vim.lsp.config("lua_ls", {
		capabilities = capa,
		on_attach = make_on_attach(),
		settings = {
			Lua = {
				completion = { callSnippet = "Replace" },
			},
		},
	})

	-- Go
	vim.lsp.config("gopls", {
		capabilities = capa,
		on_attach = make_on_attach(function(_, bufnr)
			attach_float_diagnostics(bufnr)
		end),
	})

	-- Python
	vim.lsp.config("pyright", {
		capabilities = capa,
		on_attach = make_on_attach(function(_, bufnr)
			attach_float_diagnostics(bufnr)
		end),
	})

	-- JSON
	vim.lsp.config("jsonls", {
		capabilities = capa,
		on_attach = make_on_attach(),
		init_options = { provideFormatter = true },
	})

	-- YAML
	vim.lsp.config("yamlls", {
		capabilities = capa,
		on_attach = make_on_attach(),
	})

	-- XML (lemminx)
	vim.lsp.config("lemminx", {
		capabilities = capa,
		on_attach = make_on_attach(),
	})

	-- Helm
	vim.lsp.config("helm_ls", {
		capabilities = capa,
		on_attach = make_on_attach(),
	})

	-- enable per-server (czytelnie i bez “enable({})”)
	for _, name in ipairs({ "lua_ls", "gopls", "pyright", "jsonls", "yamlls", "lemminx", "helm_ls" }) do
		vim.lsp.enable(name)
	end
end

return M
