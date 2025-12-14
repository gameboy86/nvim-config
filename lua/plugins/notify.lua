return {
	"rcarriga/nvim-notify",
	opts = {
		timeout = 5000,
	},
	config = function(_, opts)
		local notify = require("notify")
		notify.setup(opts)
	end,
}
