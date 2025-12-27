-- config/obsidian/frontmatter.lua
-- Frontmatter generator for Obsidian notes.
-- Keeps user-defined metadata and adds/normalizes fields.

local M = {}

---@param note table
---@return table
function M.note_frontmatter(note)
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

	-- Preserve manually added metadata fields.
	if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
		for k, v in pairs(note.metadata) do
			out[k] = v
		end
	end

	return out
end

return M
