local M = {}

local function month_year()
	return os.date("%m.%Y")
end

---@param note table
---@return table
local function note_frontmatter(note)
	-- alias = title
	if note.title then
		note:add_alias(note.title)
	end

	local resources = false
	for _, v in pairs(note.tags or {}) do
		if v == "resource" then
			resources = true
			break
		end
	end

	local out
	if resources then
		out = { id = note.id, aliases = note.aliases, tags = note.tags }
	else
		out = { id = note.id, aliases = note.aliases, tags = note.tags, area = "", project = "" }
	end

	-- zachowaj ręcznie dodane pola
	if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
		for k, v in pairs(note.metadata) do
			out[k] = v
		end
	end

	return out
end

function M.opts()
	return {
		ui = { enable = false },
		completion = {
			nvim_cmp = true,
			min_chars = 2,
		},
		workspaces = {
			{
				name = "second_brain",
				path = "~/Documents/second_brain",
				overrides = {
					notes_subdir = "0. Inbox",
					templates = {
						folder = "Templates",
						date_format = "%Y-%m-%d",
						time_format = "%H:%M",
						substitutions = {
							my = month_year,
						},
					},
				},
			},
		},
		new_notes_location = "notes_subdir",
		prepend_note_id = true,
		note_frontmatter_func = note_frontmatter,
	}
end

return M
