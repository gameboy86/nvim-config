local M = {}

local function enable_cmp()
	local mode = vim.api.nvim_get_mode().mode

	-- cmdline: enable tylko dla :, /, ?
	if mode == "c" then
		local t = vim.fn.getcmdtype()
		return (t == ":" or t == "/" or t == "?")
	end

	-- dap prompt buffers
	if vim.bo.buftype == "prompt" then
		local ok, cmp_dap = pcall(require, "cmp_dap")
		if ok and cmp_dap.is_dap_buffer() then
			return true
		end
		return false
	end

	return true
end

local function snippet_expand(args)
	require("luasnip").lsp_expand(args.body)
end

function M.setup()
	local cmp = require("cmp")
	local lspkind = require("lspkind")

	-- snippets
	require("luasnip.loaders.from_vscode").lazy_load()

	local border_opts = {
		border = "rounded",
		winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
	}

	local cmdline_mapping = {
		["<C-j>"] = { c = cmp.mapping.select_next_item() },
		["<C-k>"] = { c = cmp.mapping.select_prev_item() },
		["<CR>"] = { c = cmp.mapping.confirm({ select = false }) },
		["<C-e>"] = { c = cmp.mapping.abort() },
	}

	-- cmdline search
	cmp.setup.cmdline({ "/", "?" }, {
		mapping = cmdline_mapping,
		sources = { { name = "buffer" } },
	})

	-- cmdline commands
	cmp.setup.cmdline(":", {
		mapping = cmdline_mapping,
		sources = cmp.config.sources({
			{ name = "path" },
			{ name = "cmdline" },
		}),
	})

	-- insert mode
	cmp.setup({
		enabled = enable_cmp,
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
		snippet = { expand = snippet_expand },
		window = {
			completion = cmp.config.window.bordered(border_opts),
			documentation = cmp.config.window.bordered(border_opts),
		},
		mapping = cmp.mapping.preset.insert({
			["<Leader><Leader>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<CR>"] = cmp.mapping.confirm({ select = true }),

			["<C-j>"] = cmp.mapping(function(fallback)
				local luasnip = require("luasnip")
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
			end, { "i", "s" }),

			["<C-k>"] = cmp.mapping(function(fallback)
				local luasnip = require("luasnip")
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

	-- dap repl/filetype
	cmp.setup.filetype({ "dap-repl" }, {
		sources = { { name = "dap" } },
	})
end

return M
