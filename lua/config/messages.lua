local M = {}

local function get_messages_lines()
	local out = vim.api.nvim_exec2("messages", { output = true }).output
	return vim.split(out, "\n", { trimempty = true })
end

local function open_messages_split(cursorline)
	local lines = get_messages_lines()

	vim.cmd("botright new")
	local buf = vim.api.nvim_get_current_buf()

	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].swapfile = false
	vim.bo[buf].modifiable = true
	vim.bo[buf].filetype = "messages"

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.bo[buf].modifiable = false

	vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, silent = true })

	cursorline = cursorline or #lines
	cursorline = math.max(1, math.min(cursorline, #lines))
	vim.api.nvim_win_set_cursor(0, { cursorline, 0 })
end

local function telescope_messages()
	local ok, _ = pcall(require, "telescope")
	if not ok then
		vim.notify("Telescope not available", vim.log.levels.WARN)
		return
	end

	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")
	local previewers = require("telescope.previewers")
	local sorters = require("telescope.sorters")

	local lines = get_messages_lines()

	local width = tostring(#lines):len() -- szerokość numeracji
	local function fmt(i, txt)
		return string.format("%" .. width .. "d │ %s", i, txt)
	end

	local items = {}
	for i, line in ipairs(lines) do
		items[i] = { idx = i, text = line }
	end

	pickers
		.new({}, {
			prompt_title = "Messages (:messages)",
			finder = finders.new_table({
				results = items,
				entry_maker = function(item)
					return {
						value = item,
						display = fmt(item.idx, item.text),
						ordinal = tostring(item.idx), -- nie używamy fuzzy, ale musi być string
					}
				end,
			}),

			-- ✅ brak fuzzy: zachowaj kolejność i nie filtruj
			sorter = sorters.highlighter_only(),

			-- ✅ preview bez path
			previewer = previewers.new_buffer_previewer({
				title = "Messages",
				define_preview = function(self, entry)
					local all = get_messages_lines()
					vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, all)

					local lnum = entry.value.idx or #all
					vim.api.nvim_win_set_cursor(self.state.winid, { lnum, 0 })
				end,
			}),

			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()
					actions.close(prompt_bufnr)
					open_messages_split(selection.value.idx)
				end)

				map("i", "<C-r>", function()
					actions.close(prompt_bufnr)
					telescope_messages()
				end)

				return true
			end,
		})
		:find()
end

function M.keymap()
	local wk = require("which-key")

	wk.add({
		{ "<leader>m", group = "messages" },
		{ "<leader>mM", open_messages_split, desc = "Open :messages (split)" },
		{ "<leader>mm", telescope_messages, desc = "Open :messages (Telescope)" },
	})
end

return M
