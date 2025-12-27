-- config/conform.lua
-- Conform.nvim configuration module.
--
-- This file returns only options (opts) used by the Conform plugin.
-- Conform is a formatter runner: it formats buffers by calling external formatters
-- (like gofmt, black, stylua, prettier) based on the current filetype.

local M = {}

function M.opts()
	return {
		-- Automatically format the buffer when you save the file.
		-- timeout_ms: maximum time Conform will wait for formatters to finish.
		-- lsp_fallback: if true, Conform will use LSP formatting when no formatter is configured.
		--              here it's false -> if there is no configured formatter, Conform won't format via LSP.
		format_on_save = {
			timeout_ms = 2000,
			lsp_fallback = false,
		},

		-- Map filetypes to a list of formatters to run.
		-- The order matters: Conform will run them in sequence.
		formatters_by_ft = {
			-- Go: goimports (imports + formatting), gofmt (standard formatter), golines (wrap long lines)
			go = { "goimports", "gofmt", "golines" },

			-- Python: isort (import sorting), black (code formatting)
			python = { "isort", "black" },

			-- JSON/JSONC: prettier (consistent formatting, supports comments in jsonc)
			json = { "prettier" },
			jsonc = { "prettier" },

			-- YAML: yamlfmt (YAML formatting)
			yaml = { "yamlfmt" },
			yml = { "yamlfmt" },

			-- XML: xmllint (format XML)
			xml = { "xmllint" },

			-- Lua: stylua (Lua formatting)
			lua = { "stylua" },
		},
	}
end

return M
