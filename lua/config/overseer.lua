local M = {}

function M.opts()
	return {
		templates = { "builtin", "user.go_run", "user.go_test", "user.go_debug" },
		default_template_prompt = "always",
	}
end

return M
