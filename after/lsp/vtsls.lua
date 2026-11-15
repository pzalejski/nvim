-- Inlay hints: useful but restrained, not everything the server supports
local inlay_hints = {
	parameterNames = { enabled = "literals" },
	parameterTypes = { enabled = true },
	functionLikeReturnTypes = { enabled = true },
	enumMemberValues = { enabled = true },
	propertyDeclarationTypes = { enabled = true },
	variableTypes = { enabled = false },
}

local language = {
	-- oxfmt formats JavaScript and TypeScript (through conform.nvim)
	format = { enable = false },
	-- Update imports after a file is renamed or moved, without asking
	updateImportsOnFileMove = { enabled = "always" },
	-- Complete functions with their call parentheses and arguments
	suggest = { completeFunctionCalls = true },
	inlayHints = inlay_hints,
}

---@type vim.lsp.Config
return {
	settings = {
		vtsls = {
			-- Use the project's own TypeScript version when it has one
			autoUseWorkspaceTsdk = true,
			enableMoveToFileCodeAction = true,
			experimental = {
				completion = { enableServerSideFuzzyMatch = true },
				maxInlayHintLength = 30,
			},
		},
		typescript = language,
		javascript = language,
	},
}
