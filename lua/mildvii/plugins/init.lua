-- Install every plugin in one call. Group files below configure them.
vim.pack.add({
	"https://github.com/omacom/aether.nvim",
	"https://github.com/rachartier/tiny-cmdline.nvim",
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

require("mildvii.plugins.ui")

-- Keymaps that use plugins, required last so every plugin is set up first.
require("mildvii.plugins.keymaps")
