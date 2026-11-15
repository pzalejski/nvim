-- Diagnostics: underlined, not updated while typing, sorted by severity
local diagnostic_icons = Mildvii.icons.diagnostics

-- Prefix the source (`ts: …`) only when several sources report on the buffer.
-- Neovim's own `source = "if_many"` counts per server, so it never labels a lone linter.
local function with_source(diagnostic)
	local sources = {}
	for _, d in ipairs(vim.diagnostic.get(diagnostic.bufnr)) do
		sources[d.source or ""] = true
	end
	if diagnostic.source and vim.tbl_count(sources) > 1 then
		return ("%s: %s"):format(diagnostic.source, diagnostic.message)
	end
	return diagnostic.message
end

vim.diagnostic.config({
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	-- Inline `● message`
	virtual_text = { prefix = "●", source = false, format = with_source },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = diagnostic_icons.ERROR,
			[vim.diagnostic.severity.WARN] = diagnostic_icons.WARN,
			[vim.diagnostic.severity.INFO] = diagnostic_icons.INFO,
			[vim.diagnostic.severity.HINT] = diagnostic_icons.HINT,
		},
	},
})

-- Redraw every source's diagnostics when any of them change, so the inline
-- `source: ` label appears once a second source reports
vim.api.nvim_create_autocmd("DiagnosticChanged", {
	group = vim.api.nvim_create_augroup("mildvii_diagnostics", { clear = true }),
	callback = function(ev)
		if vim.api.nvim_buf_is_loaded(ev.buf) then
			vim.diagnostic.show(nil, ev.buf)
		end
	end,
})
