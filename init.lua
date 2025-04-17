local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("vim_options")
require("lazy").setup("plugins")
require("keymaps")

vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		for _, file in ipairs(vim.fn.glob("__debug_bin*", true, true)) do
			local ok, err = os.remove(file)
			if ok then
				vim.notify("Delete: " .. file)
			else
				vim.notify("Delete error " .. file .. ": " .. err, vim.log.levels.WARN)
			end
		end
		-- local overseer = require("overseer")
		-- for _, task in ipairs(overseer.list_tasks()) do
		--   if task:is_running() then
		--     task:stop()
		--   end
		-- end
	end,
})
