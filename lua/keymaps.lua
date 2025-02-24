vim.keymap.set("n", "oo", "o<ESC>", {})
vim.keymap.set("n", "OO", "O<ESC>", {})
vim.keymap.set("n", "ss", "i<space><ESC>", {})
vim.keymap.set("n", "a<CR>", "i<CR><ESC>", {})
vim.keymap.set("n", "<S-l>", ":bnext<CR>", {})
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", {})
vim.keymap.set("n", "<space>", "za", {})
vim.keymap.set("n", "<leader>c", ":b#|bd#<CR>", {})
vim.keymap.set("n", "<leader>C", ":bd!<CR>", {})
-- vim.keymap.set("n", "<C-J>", "<c-e>") -- scroll one line up
-- vim.keymap.set("n", "<C-K>", "<c-y>") -- scroll one line down
-- Copy file paths
vim.keymap.set("n", "<leader>cf", '<cmd>let @+ = expand("%")<CR>', {})
vim.keymap.set("n", "<leader>cp", '<cmd>let @+ = expand("%:p")<CR>', {})

-- Resize with arrows
vim.keymap.set("n", "<C-S-Down>", ":resize +2<CR>", {})
vim.keymap.set("n", "<C-S-Up>", ":resize -2<CR>", {})
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", {})
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", {})

local lsp_open_diagnostic = function()
	vim.diagnostic.open_float()
end

local wk = require("which-key")
local tb = require("telescope.builtin")
local gits = require("gitsigns")
local utils = require("./utils")
local ssplit = require("smart-splits")
local neotest = require("neotest")

vim.keymap.set("n", "<leader>v", ":<C-u>vsplit<CR>", {})
vim.keymap.set("n", "<leader><space>", ":noh<cr>", {})
vim.keymap.set("n", "<leader>h", ":<C-u>split<CR>", {})

wk.add({
	{ "<C-Up>",    ssplit.resize_up(),    desc = "Resize split up" },
	{ "<C-Down>",  ssplit.resize_down(),  desc = "Resize split down" },
	{ "<C-Left>",  ssplit.resize_left(),  desc = "Resize split left" },
	{ "<C-Right>", ssplit.resize_right(), desc = "Resize split right" },
})

local neotest_tt = function()
	neotest.run.run(vim.fn.expand("%"))
end
local neotest_tr = function()
	neotest.run.run()
end
local neotest_tT = function()
	neotest.run.run(vim.loop.cwd())
end
local neotest_ts = function()
	neotest.summary.toggle()
end
local neotest_to = function()
	neotest.output.open({ enter = true, auto_close = true })
end
local neotest_tO = function()
	neotest.output_panel.toggle()
end
local neotest_tS = function()
	neotest.run.stop()
end

wk.add({
	{ "<leader>tt", neotest_tt, desc = "Run File" },
	{ "<leader>tr", neotest_tr, desc = "Run Nearest" },
	{ "<leader>tT", neotest_tT, desc = "Run Nearest" },
	{ "<leader>ts", neotest_ts, desc = "Toggle Summary" },
	{ "<leader>to", neotest_to, desc = "Show Output" },
	{ "<leader>tO", neotest_tO, desc = "Toggle Output Panel" },
	{ "<leader>tS", neotest_tS, desc = "Stop" },
})

wk.register({
	["<leader>x"] = { "trouble" },
	["<leader>xx"] = { require("trouble").toggle, "Toggle trouble" },
})

wk.register({
	["<leader>l"] = { name = "lsp" },
	["<leader>lk"] = { vim.lsp.buf.hover, "Hover symbol details" },
	["<leader>la"] = { vim.lsp.buf.code_action, "LSP code action" },
	["<leader>lf"] = { vim.lsp.buf.format, "Format code" },
	["<leader>lr"] = { vim.lsp.buf.rename, "Rename current symbol" },
	["<leader>lh"] = { vim.lsp.buf.signature_help, "Signature help" },
	["<leader>lD"] = { lsp_open_diagnostic, "Hover diagnostics" },
	["<leader>ld"] = { tb.lsp_definitions, "Definition of current type" },
	["<leader>lR"] = { tb.lsp_references, "List references" },
	["<leader>li"] = { tb.lsp_implementations, "Goto implementations" },
	["<leader>ly"] = { tb.lsp_type_definitions, "List type definitions" },
})
-- END LSP
local git_branches = function()
	tb.git_branches({ use_file_path = true })
end

local git_full_blame = function()
	gits.blame_line({ full = true })
end

local git_commits = function()
	tb.git_commits({ use_file_path = true })
end

local git_commits_current_file = function()
	tb.git_bcommits({ use_file_path = true })
end

local git_status = function()
	tb.git_status({ use_file_path = true })
end

wk.register({
	["<leader>g"] = { name = "git" },
	["<leader>g]"] = { gits.next_hunk, "Next Git hunk" },
	["<leader>g["] = { gits.prev_hunk, "Previous Git hunk" },
	["<leader>gl"] = { gits.blame_line, "View Git blame" },
	["<leader>gp"] = { gits.preview_hunk, "Preview Git hunk" },
	["<leader>gh"] = { gits.reset_hunk, "Reset Git hunk" },
	["<leader>gr"] = { gits.reset_buffer, "Reset Git buffer" },
	["<leader>gs"] = { gits.stage_hunk, "Stage Git hunk" },
	["<leader>gS"] = { gits.stage_buffer, "Stage Git buffer" },
	["<leader>gu"] = { gits.undo_stage_hunk, "Unstage Git hunk" },
	["<leader>gd"] = { gits.diffthis, "View Git diff" },
	["<leader>gL"] = { git_full_blame, "View full Git blame" },
	["<leader>gc"] = { git_commits, "View Git commits" },
	["<leader>gC"] = { git_commits_current_file, "View current file Git commits" },
	["<leader>ga"] = { git_status, "View Git status" },
	["<leader>gb"] = { git_branches, "List Git branches" },
})

local telescope_live_grep_visual_selected = function()
	local text = utils.functions.getVisualSelection()
	tb.live_grep({ default_text = text })
end

local telescope_find_files_visual_selected = function()
	local text = utils.functions.getVisualSelection()
	tb.find_files({ default_text = text })
end

wk.register({
	["<leader>f"] = { name = "telescope" },
	["<leader>ff"] = { tb.find_files, "Find files" },
	["<leader>fb"] = { tb.buffers, "List buffers" },
	["<leader>fw"] = { tb.live_grep, "Live grep" },
	["<leader>fo"] = { tb.oldfiles, "Find history" },
	["<leader>ft"] = { tb.help_tags, "Find help" },
	["<leader>fe"] = { tb.diagnostics, "Toggle diagnostics" },
	["<leader>fd"] = { ":TodoTelescope<CR>", "TODO list" },
	["<leader>fg"] = { ":Telescope git_signs<CR>", "List git hunks" },
	["<leader>fr"] = { ":Telescope registers<CR>", "List registers" },
})

-- TODO: how to override v-mode using witch-key ?
vim.keymap.set("v", "<leader>fw", telescope_live_grep_visual_selected)
vim.keymap.set("v", "<leader>ff", telescope_find_files_visual_selected)

wk.register({
	["<leader>e"] = { "<cmd>Neotree toggle<cr>", "Toggle Explorer" },
	-- ["<leader>o"] = {
	-- 	function()
	-- 		if vim.bo.filetype == "neo-tree" then
	-- 			vim.cmd.wincmd("p")
	-- 		else
	-- 			vim.cmd.Neotree("focus")
	-- 		end
	-- 	end,
	-- 	"Toggle Explorer Focus",
	-- },
})

wk.register({
	["<leader>u"] = { name = "undo-tree" },
	["<leader>uu"] = { "<cmd>lua require('undotree').toggle()<cr>", "Toggle undo-tree" },
})

local dapui = require("dapui")

wk.register({
	["<leader>d"] = { name = "dap" },
	["<leader>dt"] = { ":DapToggleBreakpoint<CR>", "Toggle breakpoint" },
	["<leader>dc"] = { ":DapContinue<CR>", "Continue" },
	["<leader>dx"] = { ":DapTerminate<CR>", "Terminate" },
	["<leader>do"] = { ":DapStepOver<CR>", "Step over" },
	["<leader>du"] = { dapui.toggle, "Toggle UI" },
	["<leader>de"] = { dapui.eval, "Eval" },
})

wk.add({
	{ "<leader>nd", "<cmd>NoiceDismiss<CR>", desc = "Dissmiss noice messages" },
	{ "<leader>z",  "<cmd>ZenMode<CR>",      desc = "ZenMode" },
})

-- Obsidian

local ob = require("obsidian")

local obsidian_follow_link = function()
	ob.util.gf_passthrough()
end

local obsidian_toggle_checkbox = function()
	ob.util.toggle_checkbox()
end

wk.register({
	["<leader>o"] = { name = "obsidian" },
	["<leader>of"] = { "<cmd>ObsidianFollowLink<CR>", "Follow link" },
	["<leader>od"] = { obsidian_toggle_checkbox, "Toggle checkbox", { buffer = true } },
	["<leader>oc"] = { "<cmd>ObsidianNew<CR>", "Create note", { buffer = true } },
})
