-- Mason installs language servers and tools and shows them in :Mason.
-- It doesn't configure servers; nvim-lspconfig supplies the configs, used through vim.lsp.config().
require("mason").setup({
	registries = {
		"github:mason-org/mason-registry",
		-- Provides the `roslyn` package (C#), which the main registry doesn't have
		"github:Crashdummyy/mason-registry",
	},
})

require("mason-tool-installer").setup({
	ensure_installed = {
		-- Language servers
		"lua-language-server",
		"vtsls",
		"oxlint",
		"css-lsp",
		"html-lsp",
		"basedpyright",
		"gopls",
		"roslyn",
		"bash-language-server",
		"json-lsp",
		"yaml-language-server",
		"rust-analyzer",
		"copilot-language-server",
		-- Formatters, used by conform.nvim (5.6)
		"oxfmt",
		"stylua",
		"shfmt",
		"ruff",
	},
	-- Install missing tools on startup, never update installed ones
	run_on_start = true,
	auto_update = false,
})

local servers = {
	"lua_ls",
	"vtsls",
	"oxlint",
	"cssls",
	"html",
	"basedpyright",
	"gopls",
	"roslyn_ls",
	"bashls",
	"jsonls",
	"yamlls",
	"rust_analyzer",
}

-- Every server also gets blink.cmp's completion capabilities
vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })

-- Server-specific settings live in after/lsp/<server>.lua; Neovim merges them over nvim-lspconfig's lsp/<server>.lua
vim.lsp.enable(servers)

-- Rename the current file, letting language servers update imports (workspace/willRenameFiles)
vim.api.nvim_create_user_command("RenameFile", function(opts)
	local from = vim.api.nvim_buf_get_name(0)
	if from == "" then
		return vim.notify("Buffer has no file", vim.log.levels.WARN)
	end
	local function rename(to)
		if to and to ~= "" and to ~= from then
			Mildvii.lsp.rename_file(from, to)
		end
	end
	if opts.args ~= "" then
		return rename(opts.args)
	end
	vim.ui.input({ prompt = "New file name: ", default = vim.fn.fnamemodify(from, ":."), completion = "file" }, rename)
end, { nargs = "?", complete = "file", desc = "Rename the current file and update imports" })
