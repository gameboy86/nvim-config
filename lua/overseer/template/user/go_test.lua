return {
	name = "Go: test ./...",
	builder = function()
		return {
			cmd = { "go" },
			args = { "test", "./..." },
		}
	end,
}
