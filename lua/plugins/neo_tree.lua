return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			auto_clean_after_session_restore = true,
			close_if_last_window = true,
			sources = {
				"filesystem",
				"buffers",
				"git_status",
			},
			source_selector = {
				winbar = true,
				content_layout = "center",
				sources = {
					{ source = "filesystem",  display_name = "File" },
					{ source = "buffers",     display_name = "Bufs" },
					{ source = "git_status",  display_name = "Git" },
					{ source = "diagnostics", display_name = "Diagnostic" },
				},
			},
			diagnostics = {
				bind_to_cwd = false,
				diag_sort_function = "severity",
				follow_current_file = true,
				group_dirs_and_files = true,
			},
			filesystem = {
				follow_current_file = { enabled = true },
				hijack_netrw_behavior = "open_current",
				use_libuv_file_watcher = vim.fn.has("win32") ~= 1,
			},
			commands = {
				system_open = function(state)
					-- TODO: just use vim.ui.open when dropping support for Neovim <0.10
					(vim.ui.open or require("astronvim.utils").system_open)(state.tree:get_node():get_id())
				end,
				parent_or_close = function(state)
					local node = state.tree:get_node()
					if (node.type == "directory" or node:has_children()) and node:is_expanded() then
						state.commands.toggle_node(state)
					else
						require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
					end
				end,
				child_or_open = function(state)
					local node = state.tree:get_node()
					if node.type == "directory" or node:has_children() then
						if not node:is_expanded() then -- if unexpanded, expand
							state.commands.toggle_node(state)
						else         -- if expanded and has children, seleect the next child
							require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
						end
					else -- if not a directory just open it
						state.commands.open(state)
					end
				end,
				copy_selector = function(state)
					local node = state.tree:get_node()
					local filepath = node:get_id()
					local filename = node.name
					local modify = vim.fn.fnamemodify

					local vals = {
						["BASENAME"] = modify(filename, ":r"),
						["EXTENSION"] = modify(filename, ":e"),
						["FILENAME"] = filename,
						["PATH (CWD)"] = modify(filepath, ":."),
						["PATH (HOME)"] = modify(filepath, ":~"),
						["PATH"] = filepath,
						["URI"] = vim.uri_from_fname(filepath),
					}

					local options = vim.tbl_filter(function(val)
						return vals[val] ~= ""
					end, vim.tbl_keys(vals))
					if vim.tbl_isempty(options) then
						-- utils.notify("No values to copy", vim.log.levels.WARN)
						return
					end
					table.sort(options)
					vim.ui.select(options, {
						prompt = "Choose to copy to clipboard:",
						format_item = function(item)
							return ("%s: %s"):format(item, vals[item])
						end,
					}, function(choice)
						local result = vals[choice]
						if result then
							-- utils.notify(("Copied: `%s`"):format(result))
							vim.fn.setreg("+", result)
						end
					end)
				end,
				find_in_dir = function(state)
					local node = state.tree:get_node()
					local path = node:get_id()
					require("telescope.builtin").find_files({
						cwd = node.type == "directory" and path or vim.fn.fnamemodify(path, ":h"),
					})
				end,
			},
			window = {
				mappings = {
					["<space>"] = false, -- disable space until we figure out which-key disabling
					["[b"] = "prev_source",
					["]b"] = "next_source",
					F = "find_in_dir",
					O = "system_open",
					Y = "copy_selector",
					h = "parent_or_close",
					l = "child_or_open",
					o = "open",
				},
				fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
					["<C-j>"] = "move_cursor_down",
					["<C-k>"] = "move_cursor_up",
				},
			},
			event_handlers = {
				{
					event = "file_opened",
					handler = function(file_path)
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
			},
		})
	end,
}
