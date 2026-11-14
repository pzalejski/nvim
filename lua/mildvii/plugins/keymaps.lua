-- Keymaps that use plugins. Group files hold no keymaps.
local set = vim.keymap.set

-- snacks.words: jump between occurrences of the word under the cursor
set("n", "]]", function()
	Snacks.words.jump(vim.v.count1)
end, { desc = "Next reference" })
set("n", "[[", function()
	Snacks.words.jump(-vim.v.count1)
end, { desc = "Previous reference" })

-- snacks.picker
set("n", ";f", function()
	Snacks.picker.files()
end, { desc = "Find files" })
set("n", ";r", function()
	Snacks.picker.grep()
end, { desc = "Live grep" })
set("n", ";;", function()
	Snacks.picker.resume()
end, { desc = "Resume last picker" })
set("n", [[\\]], function()
	Snacks.picker.buffers()
end, { desc = "Buffers" })
set("n", ";e", function()
	Snacks.picker.diagnostics()
end, { desc = "Diagnostics" })
set("n", ";n", function()
	Snacks.picker.notifications()
end, { desc = "Notification history" })
set("n", ";h", function()
	Snacks.picker.git_diff()
end, { desc = "Git hunks" })
