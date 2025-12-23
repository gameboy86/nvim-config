local wk = require("which-key")
local tb = require("telescope.builtin")

vim.keymap.set("n", "oo", "o<ESC>", {})
vim.keymap.set("n", "OO", "O<ESC>", {})
vim.keymap.set("n", "ss", "i<space><ESC>", {})
vim.keymap.set("n", "a<CR>", "i<CR><ESC>", {})
vim.keymap.set("n", "<S-l>", ":bnext<CR>", {})
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", {})
vim.keymap.set("n", "<space>", "za", {})
vim.keymap.set("n", "<C-S-Down>", ":resize +2<CR>", {})
vim.keymap.set("n", "<C-S-Up>", ":resize -2<CR>", {})
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", {})
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", {})
vim.keymap.set("n", "<leader>v", ":<C-u>vsplit<CR>", {})
vim.keymap.set("n", "<leader><space>", ":noh<cr>", {})
vim.keymap.set("n", "<leader>h", ":<C-u>split<CR>", {})

--------------------------------------------------
-- smart-splits (ważne: NIE wywołujemy funkcji!)
--------------------------------------------------
local ssplit = require("smart-splits")
wk.add({
	{ "<C-Up>", ssplit.resize_up, desc = "Resize split up", mode = "n" },
	{ "<C-Down>", ssplit.resize_down, desc = "Resize split down", mode = "n" },
	{ "<C-Left>", ssplit.resize_left, desc = "Resize split left", mode = "n" },
	{ "<C-Right>", ssplit.resize_right, desc = "Resize split right", mode = "n" },
})

--------------------------------------------------
-- neotest
--------------------------------------------------
-- local neotestFn = require("config/neotest_fns")
--
-- wk.add({
-- 	{ "<leader>tt", neotestFn.RunFile, desc = "Run File" },
-- 	{ "<leader>tr", neotestFn.RunNearest, desc = "Run Nearest" },
-- 	{ "<leader>td", neotestFn.RunNearestDap, desc = "Run Nearest Dap" },
-- 	{ "<leader>tT", neotestFn.RunFolder, desc = "Run Folder" },
-- 	{ "<leader>ts", neotestFn.ToggleSummary, desc = "Toggle Summary" },
-- 	{ "<leader>to", neotestFn.ShowOutput, desc = "Show Output" },
-- 	{ "<leader>tO", neotestFn.ToggleOutput, desc = "Toggle Output Panel" },
-- 	{ "<leader>tS", neotestFn.Stop, desc = "Stop" },
-- })

--------------------------------------------------
-- trouble
--------------------------------------------------
wk.add({
	{ "<leader>x", group = "trouble" },
	{
		"<leader>xx",
		function()
			require("trouble").toggle()
		end,
		desc = "Toggle trouble",
	},
})

--------------------------------------------------
-- LSP
--------------------------------------------------
local lsp_open_diagnostic = function()
	vim.diagnostic.open_float()
end

wk.add({
	{ "<leader>l", group = "lsp" },
	{ "<leader>lk", vim.lsp.buf.hover, desc = "Hover symbol details" },
	{ "<leader>la", vim.lsp.buf.code_action, desc = "LSP code action" },
	{ "<leader>lf", vim.lsp.buf.format, desc = "Format code" },
	{ "<leader>lr", vim.lsp.buf.rename, desc = "Rename current symbol" },
	{ "<leader>lh", vim.lsp.buf.signature_help, desc = "Signature help" },
	{ "<leader>lD", lsp_open_diagnostic, desc = "Hover diagnostics" },
	{ "<leader>ld", tb.lsp_definitions, desc = "Definition of current type" },
	{ "<leader>lR", tb.lsp_references, desc = "List references" },
	{ "<leader>li", tb.lsp_implementations, desc = "Goto implementations" },
	{ "<leader>ly", tb.lsp_type_definitions, desc = "List type definitions" },
})

--------------------------------------------------
-- Git (gitsigns + własne funkcje)
--------------------------------------------------
local gitFn = require("config/git_fns")
local gits = require("gitsigns")

wk.add({
	{ "<leader>g", group = "git" },
	{ "<leader>g]", gits.next_hunk, desc = "Next Git hunk" },
	{ "<leader>g[", gits.prev_hunk, desc = "Previous Git hunk" },
	{ "<leader>gl", gits.blame_line, desc = "View Git blame" },
	{ "<leader>gp", gits.preview_hunk, desc = "Preview Git hunk" },
	{ "<leader>gh", gits.reset_hunk, desc = "Reset Git hunk" },
	{ "<leader>gr", gits.reset_buffer, desc = "Reset Git buffer" },
	{ "<leader>gs", gits.stage_hunk, desc = "Stage Git hunk" },
	{ "<leader>gS", gits.stage_buffer, desc = "Stage Git buffer" },
	{ "<leader>gu", gits.undo_stage_hunk, desc = "Unstage Git hunk" },
	{ "<leader>gd", gits.diffthis, desc = "View Git diff" },
	{ "<leader>gL", gitFn.GitFullBlame, desc = "View full Git blame" },
	{ "<leader>gc", gitFn.GitCommits, desc = "View Git commits" },
	{ "<leader>gC", gitFn.GitCommitsCurrentFile, desc = "View current file Git commits" },
	{ "<leader>ga", gitFn.GitStatus, desc = "View Git status" },
	{ "<leader>gb", gitFn.GitBranches, desc = "List Git branches" },
})

--------------------------------------------------
-- Telescope (normal)
--------------------------------------------------
-- local utils = require("./utils")
--
-- local telescope_live_grep_visual_selected = function()
-- 	local text = utils.functions.getVisualSelection()
-- 	tb.live_grep({ default_text = text })
-- end
--
-- local telescope_find_files_visual_selected = function()
-- 	local text = utils.functions.getVisualSelection()
-- 	tb.find_files({ default_text = text })
-- end

wk.add({
	{ "<leader>f", group = "telescope" },
	{ "<leader>ff", tb.find_files, desc = "Find files" },
	{ "<leader>fb", tb.buffers, desc = "List buffers" },
	{ "<leader>fw", tb.live_grep, desc = "Live grep" },
	{ "<leader>fo", tb.oldfiles, desc = "Find history" },
	{ "<leader>ft", tb.help_tags, desc = "Find help" },
	{ "<leader>fe", tb.diagnostics, desc = "Diagnostics" },
	{ "<leader>fd", "<cmd>TodoTelescope<CR>", desc = "TODO list" },
	{ "<leader>fg", "<cmd>Telescope git_signs<CR>", desc = "List git hunks" },
	{ "<leader>fr", "<cmd>Telescope registers<CR>", desc = "List registers" },
})

-- Telescope (visual) – tu masz odpowiedź na "// TODO: how to override v-mode using which-key ?"
-- wk.add({
-- 	{ "<leader>fw", telescope_live_grep_visual_selected, desc = "Live grep selection", mode = "v" },
-- 	{ "<leader>ff", telescope_find_files_visual_selected, desc = "Find files selection", mode = "v" },
-- })

--------------------------------------------------
-- Neotree
--------------------------------------------------
wk.add({
	{ "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle Explorer" },
})

--------------------------------------------------
-- UndoTree
--------------------------------------------------
wk.add({
	{ "<leader>u", group = "undo-tree" },
	{ "<leader>uu", "<cmd>lua require('undotree').toggle()<cr>", desc = "Toggle undo-tree" },
})

--------------------------------------------------
-- Noice
--------------------------------------------------
wk.add({
	{ "<leader>n", group = "noice" },
	{ "<leader>nh", "<cmd>NoiceHistory<CR>", desc = "Noice history" },
	{ "<leader>nl", "<cmd>NoiceLast<CR>", desc = "Noice last message" },
	{ "<leader>nd", "<cmd>NoiceDismiss<CR>", desc = "Dismiss Noice messages" },
})

--------------------------------------------------
-- ZenMode + Fold
--------------------------------------------------

wk.add({
	{ "z", group = "folds_zen" },
	{
		"zR",
		function()
			require("ufo").openAllFolds()
		end,
		desc = "Open all folds",
	},
	{
		"zM",
		function()
			require("ufo").closeAllFolds()
		end,
		desc = "Close all folds",
	},
	{ "<leader>zz", "<cmd>ZenMode<CR>", desc = "ZenMode" },
	{ "<leader>zt", "<cmd>Twilight<CR>", desc = "Toggle Twilight" },
})
--------------------------------------------------
-- Obsidian
--------------------------------------------------
local ob = require("obsidian")

local obsidian_toggle_checkbox = function()
	ob.util.toggle_checkbox()
end

wk.add({
	{ "<leader>o", group = "obsidian" },
	{ "<leader>of", "<cmd>ObsidianFollowLink<CR>", desc = "Follow link" },
	{ "<leader>od", obsidian_toggle_checkbox, desc = "Toggle checkbox" },
	{ "<leader>oc", "<cmd>ObsidianNew<CR>", desc = "Create note" },
})

--------------------------------------------------
-- DAP
--------------------------------------------------

wk.add({
	{ "<leader>d", group = "dap" },
	{ "<leader>dt", "<cmd>DapToggleBreakpoint<CR>", desc = "Toggle breakpoint" },
	{ "<leader>dc", "<cmd>DapContinue<CR>", desc = "Continue" },
	{ "<leader>dx", "<cmd>DapTerminate<CR>", desc = "Terminate" },
	{ "<leader>do", "<cmd>DapStepOver<CR>", desc = "Step over" },
	{ "<leader>do", "<cmd>DapStepOver<CR>", desc = "Step over" },
	{
		"<leader>dh",
		function()
			local win = vim.api.nvim_get_current_win()
			if vim.api.nvim_win_get_config(win).relative ~= "" then
				vim.api.nvim_win_close(win, true)
			else
				require("dap.ui.widgets").hover()
			end
		end,
		desc = "DAP hover toggle",
	},

	-- DAP VIEW (nvim-dap-view) – bez konfliktów
	{ "<leader>dv", group = "view" },
	{ "<leader>dvt", "<cmd>DapViewToggle<CR>", desc = "View toggle" },
	{ "<leader>dvo", "<cmd>DapViewOpen<CR>", desc = "View open" },
	{ "<leader>dvc", "<cmd>DapViewClose<CR>", desc = "View close" },
})

--------------------------------------------------
-- Overseer
--------------------------------------------------
wk.add({
	{ "<leader>t", group = "tasks" },
	{ "<leader>tr", "<cmd>OverseerRun<CR>", desc = "Run task" },
	{ "<leader>tt", "<cmd>OverseerToggle<CR>", desc = "Toggle task list" },
})

--------------------------------------------------
-- NVIM-TMUX-NAVIGATOR
--------------------------------------------------
local nvim_tmux_nav = require("nvim-tmux-navigation")
wk.add({
	{ "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft, desc = "Move cursor left", mode = "n" },
	{ "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight, desc = "Move cursor right", mode = "n" },
	{ "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp, desc = "Move cursor up", mode = "n" },
	{ "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown, desc = "Move cursor down", mode = "n" },
})

--------------------------------------------------
-- opencode
--------------------------------------------------

wk.add({
	{ "<leader>b", group = "opencode" },

	{
		"<leader>ba",
		function()
			require("opencode").ask("@this: ", { submit = true })
		end,
		desc = "Ask (current context)",
		mode = { "n", "x" },
	},

	{
		"<leader>bs",
		function()
			require("opencode").select()
		end,
		desc = "Select action",
		mode = { "n", "x" },
	},

	{
		"<leader>bt",
		function()
			require("opencode").toggle()
		end,
		desc = "Toggle panel",
		mode = { "n", "t" },
	},

	{
		"<leader>br",
		function()
			return require("opencode").operator("@this ")
		end,
		desc = "Add range",
		expr = true,
		mode = { "n", "x" },
	},

	{
		"<leader>bl",
		function()
			return require("opencode").operator("@this ") .. "_"
		end,
		desc = "Add line",
		expr = true,
		mode = "n",
	},

	{
		"<leader>bu",
		function()
			require("opencode").command("session.half.page.up")
		end,
		desc = "Half page up",
		mode = "n",
	},

	{
		"<leader>bd",
		function()
			require("opencode").command("session.half.page.down")
		end,
		desc = "Half page down",
		mode = "n",
	},
})
