vim.filetype.add({
	extension = {
		work = "gowork",
		tmpl = "gotmpl",
	},
})
require("autocmd").setup()
require("options").setup()
require("init-lazy").setup()
require("keymaps").setup()
