-- mini.icons: one icon source for every plugin, also standing in for nvim-web-devicons
require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

-- tiny-cmdline: the `:` command line as a floating box, centered left to right, near the top
require("tiny-cmdline").setup({
	position = {
		x = "50%",
		y = "20%",
	},
})

-- incline: a filename tag in the top-right corner of each window, so every split says which file it holds
require("incline").setup({
	hide = {
		-- Hide the tag in the focused window when the cursor reaches its line
		cursorline = "focused_win",
	},
	render = function(props)
		local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
		if name == "" then
			name = "[No Name]"
		end
		local icon, icon_hl = MiniIcons.get("file", name)
		return {
			{ icon, group = icon_hl },
			" ",
			name,
			vim.bo[props.buf].modified and " [+]" or "",
		}
	end,
})

-- lualine: one global statusline, bubbles style
local components = Mildvii.lualine
local lualine_opts = {
	options = {
		-- A function, so lualine rebuilds the theme on every colorscheme change
		theme = components.theme,
		globalstatus = true,
		component_separators = "",
		-- No separators between sections; only the mode and position bubbles get rounded ends
		section_separators = "",
		refresh = {
			events = {
				"WinEnter",
				"BufEnter",
				"BufWritePost",
				"SessionLoadPost",
				"FileChangedShellPost",
				"VimResized",
				"Filetype",
				"CursorMoved",
				"CursorMovedI",
				"ModeChanged",
				"RecordingEnter",
			},
		},
	},
	sections = {
		lualine_a = { { "mode", separator = { left = '', right = '' }, right_padding = 2 } },
		lualine_b = { "branch" },
		lualine_c = {
			components.root_name,
			{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
			{ components.pretty_path, color = { gui = "italic" } },
		},
		lualine_x = {
			components.recording,
			{
				"diagnostics",
				symbols = {
					error = Mildvii.icons.diagnostics.ERROR,
					warn = Mildvii.icons.diagnostics.WARN,
					info = Mildvii.icons.diagnostics.INFO,
					hint = Mildvii.icons.diagnostics.HINT,
				},
			},
			"diff",
		},
		lualine_y = { "progress" },
		lualine_z = { { "location", separator = { left = '', right = '' }, left_padding = 2 } },
	},
}
require("lualine").setup(lualine_opts)

local lualine_group = vim.api.nvim_create_augroup("mildvii_lualine", { clear = true })

-- The recording register is still set during RecordingLeave, so refresh once it has cleared
vim.api.nvim_create_autocmd("RecordingLeave", {
	group = lualine_group,
	callback = function()
		vim.schedule(function()
			require("lualine").refresh()
		end)
	end,
})
