-- Toggle format-on-save for the current buffer. Manual formatting still works when it's off.
vim.api.nvim_create_user_command("ToggleFormatter", function()
	vim.b.disable_autoformat = not vim.b.disable_autoformat
	vim.notify(("Format on save %s for this buffer"):format(vim.b.disable_autoformat and "disabled" or "enabled"))
end, { desc = "Toggle format-on-save for the current buffer" })
