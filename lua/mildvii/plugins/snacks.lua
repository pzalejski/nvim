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
