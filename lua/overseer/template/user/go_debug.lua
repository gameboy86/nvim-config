return {
	name = "Go: debug (dlv headless)",
	params = {
		target = { type = "string", name = "Target", desc = "np. ./cmd/api", optional = false },
		port = { type = "string", name = "Port", optional = true, default = "2345" },
	},
	builder = function(params)
		return {
			cmd = { "dlv" },
			args = {
				"debug",
				params.target,
				"--headless",
				"--listen=127.0.0.1:" .. (params.port or "2345"),
				"--api-version=2",
				"--accept-multiclient",
			},
			-- brak strategy
		}
	end,
}
