local M = {}

function M.setup()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	local uv = vim.uv or vim.loop

	if not uv.fs_stat(lazypath) then
		local result = vim.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable",
			lazypath,
		}):wait()

		if result.code ~= 0 then
			vim.api.nvim_err_writeln("Failed to clone lazy.nvim:\n" .. (result.stderr or ""))
			return
		end
	end

	vim.opt.rtp:prepend(lazypath)

	require("lazy").setup("plugins", {
		rocks = { enabled = false },
	})
end
return M
