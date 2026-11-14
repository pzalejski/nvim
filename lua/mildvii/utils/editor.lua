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

return M
