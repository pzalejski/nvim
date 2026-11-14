-- snacks.nvim: notifier, indent guides, statuscolumn, and word highlighting.
-- Later steps turn on more of it, like the picker and the lazygit integration.
require("snacks").setup({
	notifier = { enabled = true },
	indent = { enabled = true },
	statuscolumn = { enabled = true },
	-- Highlight the word under the cursor everywhere (needs a language server)
	words = { enabled = true },
	-- Scrolling should feel instant
	scroll = { enabled = false },
})
