-- Install every plugin in one call. Group files below configure them.
vim.pack.add({})

-- Plugin group files go here, e.g. require("mildvii.plugins.ui").

-- Keymaps that use plugins, required last so every plugin is set up first.
require("mildvii.plugins.keymaps")
