return {
	"smnatale/workspace-diagnostics.nvim",
	lazy = false,
	config = function()
		require("workspace-diagnostics").setup({
			auto_trigger = true,
			notify_progress = false,
			lsp_progress = false,

			allowed_lsps = {
				"pyright",
			},

			allowed_extensions = {
				".py",
			},

			ignore_dirs = {
				"/.git/",
				"/.venv/",
				"/venv/",
				"/node_modules/",
				"/dist/",
				"/build/",
				"/.mypy_cache/",
				"/.pytest_cache/",
			},
		})
	end,
}
