return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Header (ASCII) – prosty i czytelny
		dashboard.section.header.val = {
			" ███╗   ██╗██╗   ██╗██╗███╗   ███╗",
			" ████╗  ██║██║   ██║██║████╗ ████║",
			" ██╔██╗ ██║██║   ██║██║██╔████╔██║",
			" ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
			" ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
			" ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
			"",
			"  Rentier / Go / Python / Debug / Notes",
		}

		-- Buttons (quick actions)
		dashboard.section.buttons.val = {
			dashboard.button("f", "󰈞  Find file", "<cmd>Telescope find_files<CR>"),
			dashboard.button("g", "󰊄  Live grep", "<cmd>Telescope live_grep<CR>"),
			dashboard.button("r", "  Recent files", "<cmd>Telescope oldfiles<CR>"),
			dashboard.button("t", "󱁤  Tasks (Overseer)", "<cmd>OverseerToggle<CR>"),
			dashboard.button("n", "󰙏  New note (Obsidian)", "<cmd>ObsidianNew<CR>"),
			dashboard.button("l", "󰒲  Lazy", "<cmd>Lazy<CR>"),
			dashboard.button("q", "󰩈  Quit", "<cmd>qa<CR>"),
		}

		-- Footer (np. liczba pluginów + data)
		local function footer()
			local stats = require("lazy").stats()
			local datetime = os.date(" %Y-%m-%d   %H:%M")
			return string.format("⚡ %d plugins  •  %s", stats.count, datetime)
		end
		dashboard.section.footer.val = footer()

		-- Layout spacing
		dashboard.opts.layout = {
			{ type = "padding", val = 2 },
			dashboard.section.header,
			{ type = "padding", val = 2 },
			dashboard.section.buttons,
			{ type = "padding", val = 1 },
			dashboard.section.footer,
		}

		-- Highlight groups (opcjonalnie, ale wygląda lepiej)
		dashboard.section.header.opts.hl = "Type"
		dashboard.section.buttons.opts.hl = "Keyword"
		dashboard.section.footer.opts.hl = "Comment"

		alpha.setup(dashboard.opts)

		-- nie pokazuj statusline w alpha
		-- vim.api.nvim_create_autocmd("FileType", {
		-- 	pattern = "alpha",
		-- 	callback = function()
		-- 		vim.opt_local.laststatus = 0
		-- 		vim.opt_local.showtabline = 0
		-- 	end,
		-- })
		-- vim.api.nvim_create_autocmd("BufUnload", {
		-- 	buffer = 0,
		-- 	callback = function()
		-- 		vim.opt.laststatus = 2
		-- 		vim.opt.showtabline = 2
		-- 	end,
		-- })
	end,
}
