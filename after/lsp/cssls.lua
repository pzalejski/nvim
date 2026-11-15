-- Validation stays on; empty rules aren't flagged; formatting belongs to conform.nvim
local language = {
	validate = true,
	lint = { emptyRules = "ignore" },
	format = { enable = false },
}

---@type vim.lsp.Config
return {
	settings = {
		css = language,
		scss = language,
		less = language,
	},
}
