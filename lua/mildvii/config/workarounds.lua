-- workarounds

-- Treesitter folds: "Invalid buffer id" in the foldminlines OptionSet handler.
-- Neovim tracks fold state per buffer. For a buffer whose filetype has no
-- parser, that state is only cleared by a BufUnload autocmd, so a buffer
-- wiped with autocmds suppressed (codediff's panels, for example) leaves a
-- stale entry behind. A later global 'foldminlines'/'foldnestmax' change
-- (codediff sets it via vim.wo when moving through its explorer) then walks
-- every tracked buffer and crashes on the dead one. Wrap Neovim's handler so
-- it drops entries for buffers that no longer exist first.
-- Seen on Neovim 0.12.6; remove once fixed upstream.
do
	require("vim.treesitter._fold")
	for _, au in ipairs(vim.api.nvim_get_autocmds({ event = "OptionSet" })) do
		if au.desc == "Refresh treesitter folds" and au.callback then
			local orig = au.callback
			local foldinfos
			for i = 1, math.huge do
				local name, value = debug.getupvalue(orig, i)
				if not name then
					break
				end
				if name == "foldinfos" then
					foldinfos = value
					break
				end
			end
			if foldinfos then
				vim.api.nvim_del_autocmd(au.id)
				vim.api.nvim_create_autocmd("OptionSet", {
					pattern = au.pattern,
					desc = "Refresh treesitter folds (skip deleted buffers)",
					callback = function(args)
						for bufnr in pairs(foldinfos) do
							if not vim.api.nvim_buf_is_valid(bufnr) then
								foldinfos[bufnr] = nil
							end
						end
						return orig(args)
					end,
				})
			end
		end
	end
end
