-- config/cmp/insert.lua
-- Main nvim-cmp setup for Insert mode:
-- - sources + priorities
-- - key mappings (next/prev + LuaSnip jump)
-- - formatting using lspkind
-- - window borders and documentation popups
-- Uses helpers for shared behaviors (enabled/snippet/border).
--
local M = {}

function M.setup(cmp, helpers)
	local lspkind = require("lspkind")
	local luasnip = require("luasnip")

	local border_opts = helpers.border_opts()

	cmp.setup({
		enabled = helpers.enabled,

		snippet = { expand = helpers.snippet_expand },

		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = lspkind.cmp_format({
				Array = "{}",
				Boolean = "󰀿",
				Class = "󰌗",
				Constructor = "",
				Key = "󰌆",
				Namespace = "󰅪",
				Null = "NULL",
				Number = "#",
				Object = "󰀚",
				Package = "󰏗",
				Property = "",
				Reference = "",
				Snippet = "",
				String = "󰀬",
				TypeParameter = "󰊄",
				Unit = "",
			}),
		},

		window = {
			completion = cmp.config.window.bordered(border_opts),
			documentation = cmp.config.window.bordered(border_opts),
		},

		mapping = cmp.mapping.preset.insert({
			["<Leader><Leader>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<CR>"] = cmp.mapping.confirm({ select = true }),

			-- Next item OR snippet jump forward.
			["<C-j>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
			end, { "i", "s" }),

			-- Prev item OR snippet jump backward.
			["<C-k>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		}),

		sources = cmp.config.sources({
			{ name = "nvim_lsp", priority = 1000 },
			{ name = "luasnip", priority = 750 },
			{ name = "path", priority = 500 },
			{ name = "render-markdown", priority = 400 },
			{ name = "buffer", priority = 200 },
		}),

		sorting = {
			comparators = {
				cmp.config.compare.kind,
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.score,
			},
		},
	})
end

return M
