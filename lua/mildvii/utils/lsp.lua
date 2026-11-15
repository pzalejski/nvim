local M = {}

--- Whether a client wants to hear about renaming `path`, going by its
--- `workspace.fileOperations.<op>.filters` capability.
---@param client vim.lsp.Client
---@param op "willRename"|"didRename"
---@param path string
---@return boolean
local function wants_rename(client, op, path)
	local ops = vim.tbl_get(client.server_capabilities, "workspace", "fileOperations", op)
	if not ops then
		return false
	end
	local is_dir = vim.fn.isdirectory(path) == 1
	for _, filter in ipairs(ops.filters or {}) do
		local pattern = filter.pattern
		local kind_ok = not pattern.matches or (pattern.matches == "folder") == is_dir
		local scheme_ok = not filter.scheme or filter.scheme == "file"
		if kind_ok and scheme_ok and vim.glob.to_lpeg(pattern.glob):match(path) then
			return true
		end
	end
	return false
end

--- Rename a file on disk and let language servers update references to it.
--- Sends `workspace/willRenameFiles` before and `workspace/didRenameFiles` after,
--- only to servers whose capabilities say they handle the file.
---@param from string
---@param to string
---@return boolean ok
function M.rename_file(from, to)
	from, to = vim.fs.normalize(vim.fn.fnamemodify(from, ":p")), vim.fs.normalize(vim.fn.fnamemodify(to, ":p"))
	local changes = { files = { { oldUri = vim.uri_from_fname(from), newUri = vim.uri_from_fname(to) } } }
	local clients = vim.lsp.get_clients()

	for _, client in ipairs(clients) do
		if client:supports_method("workspace/willRenameFiles") and wants_rename(client, "willRename", from) then
			local resp = client:request_sync("workspace/willRenameFiles", changes, 1000, 0)
			if resp and resp.result then
				vim.lsp.util.apply_workspace_edit(resp.result, client.offset_encoding)
			end
		end
	end

	vim.fn.mkdir(vim.fs.dirname(to), "p")
	if vim.fn.rename(from, to) ~= 0 then
		vim.notify("Failed to rename " .. from, vim.log.levels.ERROR)
		return false
	end

	-- Show the renamed file in every window that showed the old one
	local from_buf = vim.fn.bufnr(from)
	if from_buf ~= -1 then
		local to_buf = vim.fn.bufadd(to)
		vim.bo[to_buf].buflisted = true
		for _, win in ipairs(vim.fn.win_findbuf(from_buf)) do
			vim.api.nvim_win_set_buf(win, to_buf)
		end
		vim.api.nvim_buf_delete(from_buf, { force = true })
	end

	for _, client in ipairs(clients) do
		if client:supports_method("workspace/didRenameFiles") and wants_rename(client, "didRename", to) then
			client:notify("workspace/didRenameFiles", changes)
		end
	end
	return true
end

return M
