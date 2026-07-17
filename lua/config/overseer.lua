local M = {}

function M.setup(overseer_opts)
	overseer_opts = overseer_opts or {}
	local overseer = require("overseer")

	overseer_opts.task_list = overseer_opts.task_list or {}
	overseer_opts.task_list.keymaps = vim.tbl_extend("force", overseer_opts.task_list.keymaps or {}, {
		-- zdejmij domyślne
		["<C-j>"] = false,
		["<C-k>"] = false,

		-- nowe
		["<C-S-j>"] = "keymap.scroll_output_down",
		["<C-S-k>"] = "keymap.scroll_output_up",
	})

	overseer.register_template({
		name = "Zig: test current file",
		builder = function()
			local file = vim.api.nvim_buf_get_name(0)
			return {
				cmd = "zig",
				args = { "test", file },
				cwd = vim.fn.getcwd(),
			}
		end,
		condition = {
			filetype = { "zig" },
		},
	})

	overseer.setup(overseer_opts)

	local telescope = require("telescope")
	telescope.setup({
		extensions = {
			["ui-select"] = require("telescope.themes").get_dropdown({}),
		},
	})
	telescope.load_extension("ui-select")
end

function M.keymap()
	local wk = require("which-key")

	wk.add({
		{ "<leader>r", group = "Overseer" },
		{ "<leader>rr", "<cmd>OverseerRun<cr>", desc = "Run task (Make targets)" },
		{ "<leader>rt", "<cmd>OverseerToggle<cr>", desc = "Toggle task list" },
	})
end

return M
