-- snacks.nvim: dashboard, notifier, indent guides, statuscolumn, word highlighting,
-- picker, and the lazygit integration.

-- Dashboard logo colors follow the theme, including after a theme switch
Mildvii.dashboard.set_hl()
vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("mildvii_dashboard", { clear = true }),
	callback = Mildvii.dashboard.set_hl,
})

-- Git panes only make sense inside a repo
local function in_git_repo()
	return Snacks.git.get_root() ~= nil
end

require("snacks").setup({
	dashboard = {
		width = 60,
		pane_gap = 4,
		preset = {
			keys = {
				{
					icon = " ",
					key = "f",
					desc = "Find file",
					action = function()
						Snacks.picker.files()
					end,
				},
				{
					icon = " ",
					key = "g",
					desc = "Grep",
					action = function()
						Snacks.picker.grep()
					end,
				},
				{
					icon = " ",
					key = "r",
					desc = "Recent files",
					action = function()
						Snacks.picker.recent()
					end,
				},
				{
					icon = " ",
					key = "p",
					desc = "Projects",
					action = function()
						Snacks.picker.projects()
					end,
				},
				{
					icon = " ",
					key = "c",
					desc = "Config",
					action = function()
						Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
					end,
				},
				{
					icon = "󰊢 ",
					key = "l",
					desc = "Lazygit",
					action = function()
						Mildvii.git.lazygit()
					end,
				},
				{ icon = "󱌢 ", key = "m", desc = "Mason", action = ":Mason" },
				{
					icon = "󰚰 ",
					key = "u",
					desc = "Update plugins",
					action = function()
						vim.pack.update()
					end,
				},
				{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
			},
		},
		sections = {
			{ text = Mildvii.dashboard.logo(), align = "center", padding = 1 },
			-- Blank spacer that centers the right pane on the logo when the panes sit side by side.
			-- Heights: 9 keys + 1 padding, and each git pane is title + 5 rows + 1 padding.
			-- (Not top padding on the keys: snacks then records the keys' rows too high,
			-- and the cursor gets stuck.)
			function()
				local two_panes = vim.o.columns >= 60 * 2 + 4
				local right = 9 + (in_git_repo() and 1 + 7 + 6 or 0)
				local top = math.floor((Mildvii.dashboard.logo_height - right) / 2)
				-- An empty item takes one row plus its padding
				return { pane = 2, padding = top - 1, enabled = two_panes and top > 0 }
			end,
			{ pane = 2, section = "keys", padding = 1 },
			{
				pane = 2,
				icon = " ",
				title = "Git status",
				section = "terminal",
				enabled = in_git_repo,
				cmd = "git status --short --branch --renames",
				height = 5,
				padding = 1,
				ttl = 5 * 60,
				indent = 3,
			},
			{
				pane = 2,
				icon = " ",
				title = "Recent commits",
				section = "terminal",
				enabled = in_git_repo,
				cmd = "git --no-pager log --oneline --color -n 5",
				height = 5,
				padding = 1,
				ttl = 5 * 60,
				indent = 3,
			},
			Mildvii.dashboard.footer,
		},
	},
	notifier = { enabled = true },
	indent = { enabled = true },
	statuscolumn = { enabled = true },
	-- Highlight the word under the cursor everywhere (needs a language server)
	words = { enabled = true },
	-- Scrolling should feel instant
	scroll = { enabled = false },
	lazygit = {
		-- Write the colorscheme to a theme file loaded alongside ~/.config/lazygit/config.yml
		configure = true,
		theme = {
			activeBorderColor = { fg = "WarningMsg", bold = true },
		},
		config = {
			os = {
				editPreset = "",
				-- Run the edit command in the background, so lazygit stays live and receives the `q`
				-- that quits it (instead of pausing on "Press enter to return to lazygit")
				editInTerminal = false,
				-- `e` quits lazygit, focuses the window it was opened from, then opens the file there.
				-- Outside Neovim it just runs `nvim <file>`. Wrapped in `sh -c` so it runs the same
				-- whichever shell lazygit uses (bash, fish, ...).
				edit = [[sh -c 'if [ -z "$NVIM" ]; then nvim -- "$1"; else nvim --server "$NVIM" --remote-send q; nvim --server "$NVIM" --remote-send "<Cmd>lua Mildvii.git.focus_lazygit_origin()<CR>"; nvim --server "$NVIM" --remote "$1"; fi' _ {{filename}}]],
				editAtLine = [[sh -c 'if [ -z "$NVIM" ]; then nvim +"$2" -- "$1"; else nvim --server "$NVIM" --remote-send q; nvim --server "$NVIM" --remote-send "<Cmd>lua Mildvii.git.focus_lazygit_origin()<CR>"; nvim --server "$NVIM" --remote "$1"; nvim --server "$NVIM" --remote-send "<Cmd>$2<CR>"; fi' _ {{filename}} {{line}}]],
			},
		},
	},
	picker = {
		enabled = true,
		sources = {
			-- Dotfiles like `.github/` and `.env.example` are part of real projects
			files = { hidden = true },
			grep = { hidden = true },
			-- Jump to a window that already shows the buffer
			buffers = { jump = { reuse_win = true } },
		},
	},
})
