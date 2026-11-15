local M = {}

--- Open the current file as of the commit that last touched the cursor line, in a new tab.
--- The cursor lands on the same line in that version.
function M.open_line_commit()
	local file = vim.api.nvim_buf_get_name(0)
	if file == "" then
		return vim.notify("Buffer has no file", vim.log.levels.WARN)
	end
	local dir = vim.fs.dirname(file)
	local line = vim.fn.line(".")

	local blame = vim.system(
		{ "git", "blame", "--porcelain", "-L", line .. "," .. line, "--", vim.fs.basename(file) },
		{ cwd = dir, text = true }
	):wait()
	if blame.code ~= 0 then
		return vim.notify("git blame failed: " .. vim.trim(blame.stderr), vim.log.levels.ERROR)
	end

	-- First line: `<sha> <original line> <final line> ...`; `filename` gives the path in that commit
	local sha, orig_line = blame.stdout:match("^(%x+) (%d+)")
	local path = blame.stdout:match("\nfilename ([^\n]+)")
	if not sha or sha:match("^0+$") then
		return vim.notify("This line isn't committed yet", vim.log.levels.WARN)
	end

	local root = vim.trim(vim.system({ "git", "rev-parse", "--show-toplevel" }, { cwd = dir, text = true }):wait().stdout)
	local show = vim.system({ "git", "show", sha .. ":" .. path }, { cwd = root, text = true }):wait()
	if show.code ~= 0 then
		return vim.notify("git show failed: " .. vim.trim(show.stderr), vim.log.levels.ERROR)
	end

	local filetype = vim.bo.filetype
	vim.cmd.tabnew()
	local buf = vim.api.nvim_get_current_buf()
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(show.stdout, "\n", { trimempty = true }))
	vim.api.nvim_buf_set_name(buf, ("%s:%s"):format(sha:sub(1, 8), path))
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].modifiable = false
	vim.bo[buf].filetype = filetype
	pcall(vim.api.nvim_win_set_cursor, 0, { tonumber(orig_line), 0 })
end

return M
