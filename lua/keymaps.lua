local M = {}

function M.setup()
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

	vim.keymap.set("n", "n", "nzzzv")
	vim.keymap.set("n", "N", "Nzzzv")
	vim.keymap.set("n", "*", "*zzzv")
	vim.keymap.set("n", "#", "#zzzv")
	vim.keymap.set("n", "g*", "g*zzzv")
	vim.keymap.set("n", "g#", "g#zzzv")

	vim.keymap.set("n", "<C-d>", "<C-d>zz")
	vim.keymap.set("n", "<C-u>", "<C-u>zz")

	vim.keymap.set("i", "jk", "<Esc>", { noremap = true })

	local STEP = 2

	vim.keymap.set("n", "<C-Up>", function()
		vim.cmd("resize +" .. STEP)
	end, { desc = "Resize split up" })

	vim.keymap.set("n", "<C-Down>", function()
		vim.cmd("resize -" .. STEP)
	end, { desc = "Resize split down" })

	vim.keymap.set("n", "<C-Left>", function()
		vim.cmd("vertical resize -" .. STEP)
	end, { desc = "Resize split left" })

	vim.keymap.set("n", "<C-Right>", function()
		vim.cmd("vertical resize +" .. STEP)
	end, { desc = "Resize split right" })

	require("config.diagnostics").keymap()
	require("config.messages").keymap()
end

return M
