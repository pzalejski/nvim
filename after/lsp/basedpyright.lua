---@type vim.lsp.Config
return {
	settings = {
		basedpyright = {
			-- Ruff handles import sorting and linting; basedpyright handles types and language intelligence
			disableOrganizeImports = true,
		},
	},
}
