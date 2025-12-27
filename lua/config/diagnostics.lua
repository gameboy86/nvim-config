local M = {}

local function todo_pattern()
	-- łapie: TODO, #TODO, TODO:, TODO coś, TODO) itd.
	return [[(?:#\s*)?\b(TODO|FIXME|FIX|BUG|HACK|NOTE|WARN|WARNING|PERF|OPTIM|TEST)\b(?::|\s|$)]]
end

function M.todos()
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local make_entry = require("telescope.make_entry")

	local args = {
		"rg",
		"--pcre2",
		"--ignore-case",
		"--column",
		"--line-number",
		"--no-heading",
		"--color=never",
		"--smart-case",

		"--hidden",
		"--glob=!.git/*",
		"--glob=!node_modules/*",
		"--glob=!.venv/*",
		"--glob=!dist/*",

		"--regexp",
		todo_pattern(),
	}

	pickers
		.new({}, {
			prompt_title = "Todos",
			finder = finders.new_oneshot_job(args, {
				entry_maker = make_entry.gen_from_vimgrep({}),
			}),
			previewer = conf.grep_previewer({}),
			sorter = conf.generic_sorter({}),
		})
		:find()
end

function M.setup()
	vim.diagnostic.config({
		underline = true,
		virtual_text = false,
		update_in_insert = true,
		severity_sort = true,
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = " ",
				[vim.diagnostic.severity.WARN] = " ",
				[vim.diagnostic.severity.HINT] = " ",
				[vim.diagnostic.severity.INFO] = " ",
			},
		},
	})
end

function M.keymap()
	local wk = require("which-key")
	local tb = require("telescope.builtin")

	wk.add({
		{ "<leader>x", group = "diagnostics" },

		{ "<leader>xF", tb.diagnostics, desc = "Workspace diagnostics" },
		{
			"<leader>xf",
			function()
				tb.diagnostics({ bufnr = 0 })
			end,
			desc = "Buffer diagnostics",
		},
		{
			"<leader>xd",
			function()
				vim.diagnostic.open_float()
			end,
			desc = "Hover diagnostics",
		},
		{
			"<leader>xt",
			function()
				M.todos()
			end,
			desc = "Todos (live_grep)",
		},
	})
end

return M
