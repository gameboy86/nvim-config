local M = {}

function M.opts()
	return {
		format_on_save = false,

		formatters_by_ft = {
			go = { "goimports", "gofmt", "golines" },
			python = { "isort", "black" },
			json = { "prettier" },
			jsonc = { "prettier" },
			yaml = { "yamlfmt" },
			yml = { "yamlfmt" },
			xml = { "xmllint" },
			lua = { "stylua" },
		},
	}
end

function M.init()
	local conform = require("conform")
	local group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })

	vim.api.nvim_create_autocmd("BufWritePre", {
		group = group,
		callback = function(args)
			if vim.g.disable_autoformat or vim.b[args.buf].disable_autoformat then
				return
			end

			conform.format({
				bufnr = args.buf,
				timeout_ms = 2000,
				lsp_format = "never",
			})
		end,
	})

	vim.api.nvim_create_user_command("FormatDisable", function(opts)
		if opts.bang then
			-- tylko bieżący buffer
			vim.b.disable_autoformat = true
		else
			vim.g.disable_autoformat = true
		end
	end, { bang = true, desc = "Disable autoformat-on-save" })

	vim.api.nvim_create_user_command("FormatEnable", function()
		vim.b.disable_autoformat = false
		vim.g.disable_autoformat = false
	end, { desc = "Enable autoformat-on-save" })
end

return M
