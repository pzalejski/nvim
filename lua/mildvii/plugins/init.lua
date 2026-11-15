-- Plugin hooks, registered before vim.pack.add so they also run on first install
vim.api.nvim_create_autocmd("PackChanged", {
	group = vim.api.nvim_create_augroup("mildvii_pack", { clear = true }),
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		-- Keep Treesitter parsers in sync with the nvim-treesitter version
		if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
})

-- Install every plugin in one call. Group files below configure them.
vim.pack.add({
	"https://github.com/omacom/aether.nvim",
	"https://github.com/nvim-mini/mini.icons",
	"https://github.com/folke/snacks.nvim",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/b0o/incline.nvim",
	"https://github.com/rachartier/tiny-cmdline.nvim",
	"https://github.com/stevearc/oil.nvim",
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	"https://github.com/folke/todo-comments.nvim",
	"https://github.com/catgoose/nvim-colorizer.lua",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
	"https://github.com/nvim-mini/mini.pairs",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/nvim-mini/mini.diff",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/esmuellert/codediff.nvim",
})

-- Colorscheme: theme.lua is a symlink to the file Omarchy generates for the current theme.
-- It returns a lazy.nvim-style spec; the first entry holds aether's opts.
-- aether.setup() also starts aether.hotreload, which re-applies the colors when Omarchy rewrites the file.
local theme = require("mildvii.plugins.theme")
local aether_spec = type(theme) == "table" and theme[1] or {}
if type(aether_spec[1]) == "string" and aether_spec[1]:match("aether") then
	require("aether").setup(aether_spec.opts)
else
	-- Themes that ship their own Neovim colorscheme plugin fall back to aether's default palette
	require("aether").setup()
end
vim.cmd.colorscheme("aether")

require("mildvii.plugins.snacks")
require("mildvii.plugins.ui")
require("mildvii.plugins.navigation")
require("mildvii.plugins.syntax")
require("mildvii.plugins.completion")
require("mildvii.plugins.lsp")
require("mildvii.plugins.formatting")
require("mildvii.plugins.git")

-- Keymaps that use plugins, required last so every plugin is set up first.
require("mildvii.plugins.keymaps")
