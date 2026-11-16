-- Start time, for the dashboard footer
vim.g.mildvii_start = vim.uv.hrtime()

vim.loader.enable()

_G.Mildvii = require("mildvii.utils")

require("mildvii.config.options")
require("mildvii.config.keymaps")
require("mildvii.config.autocmds")
require("mildvii.config.diagnostics")
require("mildvii.config.commands")
require("mildvii.config.workarounds")

require("mildvii.plugins")
