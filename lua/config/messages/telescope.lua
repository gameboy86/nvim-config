-- config/messages/telescope.lua
-- Telescope picker UI for :messages:
-- - filter by content / line number
-- - preview full output and jump to selected line
-- - <C-r> refreshes messages without closing the picker

local M = {}

local data = require("config.messages.data")
local split = require("config.messages.split")

local function ensure_telescope()
	local ok = pcall(require, "telescope")
	if not ok then
		vim.notify("Telescope not available", vim.log.levels.WARN)
		return false
	end
	return true
end

local function build_items(lines)
	local width = tostring(#lines):len()
	local items = {}
	for i, line in ipairs(lines) do
		items[i] = {
			idx = i,
			text = line,
			display = string.format("%" .. width .. "d │ %s", i, line),
		}
	end
	return items
end

local function make_finder(finders, lines)
	return finders.new_table({
		results = build_items(lines),
		entry_maker = function(item)
			return {
				value = item,
				display = item.display,
				ordinal = tostring(item.idx) .. " " .. item.text, -- filter by number or text
			}
		end,
	})
end

function M.open()
	if not ensure_telescope() then
		return
	end

	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")
	local previewers = require("telescope.previewers")
	local conf = require("telescope.config").values

	-- Cache per picker session; refresh updates this variable.
	local lines = data.fetch_lines()

	pickers
		.new({}, {
			prompt_title = "Messages (:messages)",
			finder = make_finder(finders, lines),
			sorter = conf.generic_sorter({}),
			previewer = previewers.new_buffer_previewer({
				title = "Messages",
				define_preview = function(self, entry)
					vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
					local lnum = data.clamp(entry.value.idx or #lines, 1, #lines)
					vim.api.nvim_win_set_cursor(self.state.winid, { lnum, 0 })
				end,
			}),

			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()
					actions.close(prompt_bufnr)
					split.open(lines, selection.value.idx)
				end)

				-- Refresh messages without closing the picker.
				map({ "i", "n" }, "<C-r>", function()
					lines = data.fetch_lines()
					local picker = action_state.get_current_picker(prompt_bufnr)
					picker:refresh(make_finder(finders, lines), { reset_prompt = false })
				end)

				return true
			end,
		})
		:find()
end

return M
