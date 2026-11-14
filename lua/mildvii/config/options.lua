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

-- Hybrid line numbers: relative everywhere, real number on the cursor line
opt.number = true
opt.relativenumber = true

opt.cursorline = true
opt.wrap = false
opt.scrolloff = 10
opt.sidescrolloff = 8

-- Always show the sign column, so text doesn't jump when git or diagnostic marks appear
opt.signcolumn = "yes"

-- Maximize vertical space: no command line row, one global statusline
opt.cmdheight = 0
opt.laststatus = 3

-- Rounded borders on every float
opt.winborder = "rounded"

-- Popup menu: at most 10 rows, slightly see-through
opt.pumheight = 10
opt.pumblend = 10

-- Briefly flash the matching bracket
opt.showmatch = true
opt.matchtime = 2

-- Show the file name in the terminal tab
opt.title = true

-- Diagonal fill in empty diff areas
opt.fillchars:append({ diff = "╱" })

-- Case-insensitive search until a capital letter is typed
opt.ignorecase = true
opt.smartcase = true

-- Let `:find` search subfolders
opt.path:append("**")

-- `:` completion
opt.wildmode = "longest:full,full"
opt.wildignore:append({ "*/node_modules/*", "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })

-- No swap or backup files; persistent undo survives closing the file
opt.swapfile = false
opt.writebackup = false
opt.undofile = true
local undodir = vim.fn.stdpath("cache") .. "/undodir"
vim.fn.mkdir(undodir, "p")
opt.undodir = undodir

-- Snappier timing: faster CursorHold events, key sequences resolve without lag
opt.updatetime = 300
opt.timeoutlen = 500
opt.ttimeoutlen = 0

-- New splits open below and to the right
opt.splitbelow = true
opt.splitright = true

-- Folds come from Treesitter; everything starts unfolded
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
