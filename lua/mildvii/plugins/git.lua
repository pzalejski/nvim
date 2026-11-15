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

-- codediff: side-by-side diffs and history, for reviewing large sets of changes
require("codediff").setup({
	diff = {
		-- Compact mode: only changes plus 8 context lines, with folds synced across panes
		compact = true,
		compact_context_lines = 8,
		compact_sync_folds = true,
	},
	explorer = {
		view_mode = "tree",
		width = 50,
		-- Open the file under the cursor as it moves
		auto_open_on_cursor = true,
		-- Show +/- line stats per file
		line_stats = { enabled = true },
	},
})
