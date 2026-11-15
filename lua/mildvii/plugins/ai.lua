-- copilot.lua: inline suggestions as you type. Run `:Copilot auth` once.
require("copilot").setup({
	-- Use the copilot-language-server Mason installs (plugins/lsp.lua) instead of a second download
	server = {
		type = "binary",
		custom_server_filepath = vim.fn.exepath("copilot-language-server"),
	},
	suggestion = {
		auto_trigger = true,
		-- Keys live in plugins/keymaps.lua
		keymap = {
			accept = false,
			accept_word = false,
			accept_line = false,
			next = false,
			prev = false,
			dismiss = false,
		},
	},
	-- Notes and docs benefit from suggestions as much as code does
	filetypes = {
		markdown = true,
		help = true,
	},
})
