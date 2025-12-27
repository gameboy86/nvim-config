-- config/diagnostics/todos.lua
-- Telescope-based "TODO/FIXME/..." picker powered by ripgrep.
-- Uses PCRE2 regex to match common todo markers like:
-- TODO, #TODO, TODO:, TODO something, TODO) ...

local M = {}

local function todo_pattern()
	return [[(?:#\s*)?\b(TODO|FIXME|FIX|BUG|HACK|NOTE|WARN|WARNING|PERF|OPTIM|TEST)\b(?::|\s|$)]]
end

local function rg_args()
	return {
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
end

function M.open()
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local make_entry = require("telescope.make_entry")

	pickers
		.new({}, {
			prompt_title = "Todos",
			finder = finders.new_oneshot_job(rg_args(), {
				entry_maker = make_entry.gen_from_vimgrep({}),
			}),
			previewer = conf.grep_previewer({}),
			sorter = conf.generic_sorter({}),
		})
		:find()
end

return M
