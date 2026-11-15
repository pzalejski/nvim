---@type vim.lsp.Config
return {
	settings = {
		typescript = {
			-- oxfmt formats JavaScript and TypeScript (through conform.nvim)
			format = { enable = false },
			-- Update imports after a file is renamed or moved, without asking
			updateImportsOnFileMove = { enabled = "always" },
		},
		javascript = {
			format = { enable = false },
			updateImportsOnFileMove = { enabled = "always" },
		},
	},
}
