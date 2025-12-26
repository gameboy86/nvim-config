return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.config").setup({
			ensure_installed = { "lua", "go", "bash", "json", "yaml", "zsh", "zig", "asm", "c", "python" },
		})
	end,
}
