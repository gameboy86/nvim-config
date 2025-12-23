return {
	name = "Go: run (target)",
	params = {
		target = {
			type = "string",
			name = "Target",
			desc = "Package/dir to run (e.g. . or ./cmd/api)",
			default = "./cmd",
			optional = false,
		},
	},
	builder = function(params)
		return {
			cmd = { "go" },
			args = { "run", params.target },
		}
	end,
}
