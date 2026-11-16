local group = vim.api.nvim_create_augroup("mildvii", { clear = true })

-- Flash yanked text briefly
vim.api.nvim_create_autocmd("TextYankPost", {
	group = group,
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Only the active window shows the cursorline (never the dashboard)
vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
	group = group,
	callback = function()
		vim.wo.cursorline = vim.bo.filetype ~= "snacks_dashboard"
	end,
})
vim.api.nvim_create_autocmd("WinLeave", {
	group = group,
	callback = function()
		vim.wo.cursorline = false
	end,
})
