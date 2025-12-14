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
vim.opt.timeoutlen = 500
vim.opt.title = true
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.virtualedit = "block"
vim.opt.wrap = false
vim.opt.writebackup = false
vim.opt.foldmethod = "manual"
-- vim.opt.listchars = { eol = "↵", trail = "·", tab = "│ " }
vim.opt.listchars = { trail = "·", tab = "│ " }
vim.opt.list = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = false
vim.opt.pumheight = 10 -- height of the pop up menu

vim.diagnostic.config({
	underline = true,
	virtual_text = false,
	update_in_insert = true,
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = " ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
})

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		-- Force plain underlines for diagnostics after applying a colorscheme.
		-- Some colorschemes (and tmux/terminal setups) render diagnostic underlines as "undercurl",
		-- which may be unsupported or invisible. This ensures errors/warnings/etc. are always visible.
		for _, s in ipairs({ "Error", "Warn", "Info", "Hint" }) do
			vim.api.nvim_set_hl(0, "DiagnosticUnderline" .. s, { underline = true })
		end
	end,
})
