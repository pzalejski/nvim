-- Keymaps that use plugins. Group files hold no keymaps.
local set = vim.keymap.set

-- snacks.words: jump between occurrences of the word under the cursor
set("n", "]]", function()
	Snacks.words.jump(vim.v.count1)
end, { desc = "Next reference" })
set("n", "[[", function()
	Snacks.words.jump(-vim.v.count1)
end, { desc = "Previous reference" })
