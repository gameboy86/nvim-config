vim.keymap.set("n", "oo", "o<ESC>", {})
vim.keymap.set("n", "OO", "O<ESC>", {})
vim.keymap.set("n", "ss", "i<space><ESC>", {})
vim.keymap.set("n", "a<CR>", "i<CR><ESC>", {})
vim.keymap.set("n", "<S-l>", ":bnext<CR>", {})
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", {})
vim.keymap.set("n", "<space>", "za", {})
vim.keymap.set("n", "<leader>c", ":bd<CR>", {})
vim.keymap.set("n", "<leader>C", ":bd!<CR>", {})

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

wk.register({
	["<C-Up>"] = { require("smart-splits").resize_up(), "Resize split up" },
	["<C-Down>"] = { require("smart-splits").resize_down(), "Resize split down" },
	["<C-Left>"] = { require("smart-splits").resize_left(), "Resize split left" },
	["<C-Right>"] = { require("smart-splits").resize_right(), "Resize split right" },
})

wk.register({
	["<leader><space>"] = { ":noh<CR>", "Clear last search highlighting" },
	["<leader>v"] = { ":<C-u>vsplit<CR>", "Split window verical" },
	["<leader>h"] = { ":<C-u>split<CR>", "Split window horizontal" },
})

wk.register({
	["<leader>tt"] = {
		function()
			require("neotest").run.run(vim.fn.expand("%"))
		end,
		"Run File",
	},
	["<leader>tT"] = {
		function()
			require("neotest").run.run(vim.loop.cwd())
		end,
		"Run All Test Files",
	},
	["<leader>tr"] = {
		function()
			require("neotest").run.run()
		end,
		"Run Nearest",
	},
	["<leader>ts"] = {
		function()
			require("neotest").summary.toggle()
		end,
		"Toggle Summary",
	},
	["<leader>to"] = {
		function()
			require("neotest").output.open({ enter = true, auto_close = true })
		end,
		"Show Output",
	},
	["<leader>tO"] = {
		function()
			require("neotest").output_panel.toggle()
		end,
		"Toggle Output Panel",
	},
	["<leader>tS"] = {
		function()
			require("neotest").run.stop()
		end,
		"Stop",
	},
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
	["<leader>o"] = {
		function()
			if vim.bo.filetype == "neo-tree" then
				vim.cmd.wincmd("p")
			else
				vim.cmd.Neotree("focus")
			end
		end,
		"Toggle Explorer Focus",
	},
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
