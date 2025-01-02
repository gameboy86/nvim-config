return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	opts = {
		filter = function(key_binding)
			-- Przykład: Ignoruj klucze, które są puste lub mają wartość nil
			return key_binding ~= nil and key_binding ~= ""
		end,
	},
}
