local M = {}

function M.setup()
	vim.g.mapleader = ","
	vim.g.background = "light"
	vim.opt.swapfile = false
	vim.wo.relativenumber = true
	vim.opt.clipboard = "unnamedplus"
	vim.opt.fileencoding = "utf-8"
	vim.opt.cursorline = true
	vim.opt.breakindent = true
	vim.opt.cmdheight = 1
	vim.opt.completeopt = { "menu", "menuone", "noselect" }
	vim.opt.copyindent = true
	vim.opt.fillchars = { eob = " " }
	vim.opt.foldenable = true
	vim.opt.foldlevel = 99
	vim.opt.foldlevelstart = 99
	vim.opt.history = 100
	vim.opt.ignorecase = true
	vim.opt.infercase = true
	vim.opt.laststatus = 3
	vim.opt.linebreak = true
	vim.opt.preserveindent = true
	vim.opt.signcolumn = "auto"
	vim.opt.smartcase = true
	vim.opt.splitbelow = true
	vim.opt.splitright = true
	vim.opt.termguicolors = true
	vim.opt.title = true
	vim.opt.undofile = true
	vim.opt.updatetime = 300
	vim.opt.virtualedit = "block"
	vim.opt.wrap = false
	vim.opt.writebackup = false
	vim.opt.foldmethod = "manual"
	vim.opt.list = true
	vim.opt.listchars = {
		tab = "│ ",
		trail = "·",
		extends = "›",
		precedes = "‹",
		nbsp = "␣",
	}
	vim.opt.pumheight = 10

	vim.opt.expandtab = true
	vim.opt.shiftwidth = 2
	vim.opt.tabstop = 2
	vim.opt.softtabstop = 2
	vim.opt.smartindent = true
	vim.opt.shiftround = true

	vim.opt.scrolloff = 8
	vim.opt.sidescrolloff = 8

	vim.opt.timeout = true
	vim.opt.timeoutlen = 300

	vim.opt.messagesopt = "hit-enter,history:1000"

	require("config.diagnostics").setup()
end

return M
