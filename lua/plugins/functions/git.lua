local M = {}
local tb = require("telescope.builtin")
local gits = require("gitsigns")

function M.GitBranches()
	tb.git_branches({ use_file_path = true })
end

function M.GitFullBlame()
	gits.blame_line({ full = true })
end

function GitCommits()
	tb.git_commits({ use_file_path = true })
end

function GitCommitsCurrentFile()
	tb.git_bcommits({ use_file_path = true })
end

function GitStatus()
	tb.git_status({ use_file_path = true })
end

return M
