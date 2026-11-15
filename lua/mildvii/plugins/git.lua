-- gitsigns: change signs in the gutter, blame, and hunk staging
require("gitsigns").setup({
	current_line_blame = true,
})

-- mini.diff: inline diff overlay against the git index. Its keymaps live in plugins/keymaps.lua.
require("mini.diff").setup({
	mappings = {
		apply = "",
		reset = "",
		textobject = "",
		goto_first = "",
		goto_prev = "",
		goto_next = "",
		goto_last = "",
	},
})
