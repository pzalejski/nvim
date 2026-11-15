---@type vim.lsp.Config
return {
	settings = {
		yaml = {
			-- Schema-aware validation stays on (the default); formatting belongs to conform.nvim
			format = { enable = false },
		},
	},
}
