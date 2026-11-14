local M = {}

-- Files or folders that mark the root of a project
M.markers = { ".git", "lua", "package.json", "Makefile", "Cargo.toml", "go.mod", "pyproject.toml" }

--- Project root for a buffer: the nearest folder above it holding a root marker.
--- Falls back to the current working directory.
---@param buf? integer
---@return string
function M.get(buf)
	buf = buf or 0
	local root = vim.api.nvim_buf_get_name(buf) ~= "" and vim.fs.root(buf, M.markers)
	return vim.fs.normalize(root or vim.fn.getcwd())
end

return M
