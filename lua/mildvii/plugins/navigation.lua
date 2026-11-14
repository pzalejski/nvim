-- oil.nvim: the directory is a buffer, so renaming, moving, and deleting files is
-- plain text editing followed by `:w`. Replaces netrw.
require("oil").setup({
	default_file_explorer = true,
	columns = { "icon", "permissions", "size", "mtime" },
	view_options = {
		show_hidden = true,
	},
	-- Renaming a file asks the LSP to update imports, and those edits are saved automatically
	lsp_file_methods = {
		enabled = true,
		autosave_changes = true,
	},
	float = {
		max_width = 200,
		border = "rounded",
	},
	-- Buffer-local keys inside oil
	keymaps = {
		["h"] = "actions.parent",
		["q"] = "actions.close",
	},
})
