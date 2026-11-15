local M = {}

--- Close every listed buffer that isn't shown in any window, except ones with unsaved changes.
function M.close_hidden_buffers()
	local closed = 0
	for _, buf in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
		if #buf.windows == 0 and buf.changed == 0 then
			vim.cmd.bdelete(buf.bufnr)
			closed = closed + 1
		end
	end
	vim.notify(("Closed %d hidden buffer%s"):format(closed, closed == 1 and "" or "s"))
end

--- Copy the current file's path with the cursor line, e.g. `lua/mildvii/config/options.lua#L12`,
--- so pasting it into an agent's prompt points at the exact line.
---@param absolute? boolean Absolute path instead of relative to the cwd
function M.copy_path(absolute)
	local name = vim.api.nvim_buf_get_name(0)
	if name == "" then
		return vim.notify("Buffer has no file", vim.log.levels.WARN)
	end
	local path = vim.fn.fnamemodify(name, absolute and ":p" or ":.")
	local text = ("%s#L%d"):format(path, vim.fn.line("."))
	vim.fn.setreg("+", text)
	vim.notify("Copied " .. text)
end

return M
