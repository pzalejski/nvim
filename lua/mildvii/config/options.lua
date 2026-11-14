-- Leader keys, set before any plugin or keymap reads them
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- Yank and paste go through the system clipboard
opt.clipboard = "unnamedplus"

-- Indent with 2 spaces
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true

-- Treat `-` as part of a word, so kebab-case names like `foo-bar` are one word
opt.iskeyword:append("-")
