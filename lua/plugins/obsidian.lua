return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		ui = {
			enable = false,
		},
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
							my = function()
								return os.date("%m.%Y")
							end
						}
					},
				},
			},
		},
		new_notes_location = "notes_subdir",
		prepend_note_id = true,

		---@return table
		note_frontmatter_func = function(note)
			-- Add the title of the note as an alias.
			if note.title then
				note:add_alias(note.title)
			end

			local resources = false
			for _, v in pairs(note.tags) do
				if v == "resource" then
					resources = true
					break
				end
			end
			local out = { id = note.id, aliases = note.aliases, tags = note.tags, area = "", project = "" }
			if resources then
				out = { id = note.id, aliases = note.aliases, tags = note.tags }
			end
			-- `note.metadata` contains any manually added fields in the frontmatter.
			-- So here we just make sure those fields are kept in the frontmatter.
			if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
				for k, v in pairs(note.metadata) do
					out[k] = v
				end
			end

			return out
		end,

	},

}
