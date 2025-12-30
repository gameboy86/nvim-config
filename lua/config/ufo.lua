local M = {}

local function handle_fallback_exception(bufnr, err, provider_name)
	if type(err) == "string" and err:match("UfoFallbackException") then
		return require("ufo").getFolds(bufnr, provider_name)
	end
	return require("promise").reject(err)
end

function M.opts()
	return {
		preview = {
			mappings = {
				scrollB = "<C-b>",
				scrollF = "<C-f>",
				scrollU = "<C-u>",
				scrollD = "<C-d>",
			},
		},
		provider_selector = function(_, filetype, buftype)
			if filetype == "" or buftype == "nofile" then
				return "indent"
			end

			return function(bufnr)
				return require("ufo")
					.getFolds(bufnr, "lsp")
					:catch(function(err)
						return handle_fallback_exception(bufnr, err, "treesitter")
					end)
					:catch(function(err)
						return handle_fallback_exception(bufnr, err, "indent")
					end)
			end
		end,
	}
end

function M.keymap()
	local wk = require("which-key")

	wk.add({
		{ "<leader>z", group = "fold zen" },
		{
			"<leader>zR",
			function()
				require("ufo").openAllFolds()
			end,
			desc = "Open all folds",
		},
		{
			"<leader>zM",
			function()
				require("ufo").closeAllFolds()
			end,
			desc = "Close all folds",
		},
	})
end

return M
