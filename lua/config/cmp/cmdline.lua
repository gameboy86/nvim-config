-- config/cmp/cmdline.lua
-- nvim-cmp configuration for Neovim's command-line:
-- - "/" and "?" use buffer source (search)
-- - ":" uses path + cmdline sources (commands)
-- Includes a small cmdline-specific mapping set.

local M = {}

function M.setup(cmp)
	local cmdline_mapping = {
		["<C-j>"] = { c = cmp.mapping.select_next_item() },
		["<C-k>"] = { c = cmp.mapping.select_prev_item() },
		["<CR>"] = { c = cmp.mapping.confirm({ select = false }) },
		["<C-e>"] = { c = cmp.mapping.abort() },
	}

	-- Search cmdline completion.
	cmp.setup.cmdline({ "/", "?" }, {
		mapping = cmdline_mapping,
		sources = { { name = "buffer" } },
	})

	-- Command cmdline completion.
	cmp.setup.cmdline(":", {
		mapping = cmdline_mapping,
		sources = cmp.config.sources({
			{ name = "path" },
			{ name = "cmdline" },
		}),
	})
end

return M
