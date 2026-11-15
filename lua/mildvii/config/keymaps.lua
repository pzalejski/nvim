local set = vim.keymap.set

-- Disable Ex mode
set("n", "Q", "<Nop>")

-- Navigate splits
set("n", "<C-j>", "<C-w><C-j>", { desc = "Move to bottom window" })
set("n", "<C-k>", "<C-w><C-k>", { desc = "Move to top window" })
set("n", "<C-l>", "<C-w><C-l>", { desc = "Move to right window" })
set("n", "<C-h>", "<C-w><C-h>", { desc = "Move to left window" })

-- Buffer navigation
set("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
set("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Close buffer" })
set("n", "<leader>bo", function()
	Mildvii.editor.close_hidden_buffers()
end, { desc = "Close hidden buffers" })

-- Keep the cursor centered when jumping or searching
set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

-- Move highlighted lines
set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

-- Window splitting
set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })

-- Alternative short split mappings
set("n", "ss", "<C-w>s", { desc = "Split window horizontally" })
set("n", "sv", "<C-w>v", { desc = "Split window vertically" })

-- Window resizing
set("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
set("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })
set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })

-- Delete/change/paste without overwriting the yank register
set({ "n", "v" }, "x", '"_x', { desc = "Delete without yanking" })
set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })
set({ "n", "v" }, "<leader>c", '"_c', { desc = "Change without yanking" })
set("x", "<leader>p", '"_dP', { desc = "Paste without overwriting yank register" })

-- Delete word without overwriting the yank register
set("n", "dw", '"_dw', { desc = "Delete word without yanking" })

-- Increment / decrement numbers
set("n", "+", "<C-a>", { desc = "Increment number" })
set("n", "-", "<C-x>", { desc = "Decrement number" })

-- Select all
set("n", "<C-a>", "ggVG", { desc = "Select all" })

-- Tabs
set("n", "te", "<cmd>tabnew<CR>", { desc = "New tab" })
set("n", "<Tab>", "<cmd>tabnext<CR>", { desc = "Next tab" })
set("n", "<S-Tab>", "<cmd>tabprevious<CR>", { desc = "Previous tab" })

-- Jump list
set("n", "<C-m>", "<C-i>", { desc = "Jump forward in jump list" })

-- Open lines without continuing comments
set("n", "<leader>o", "o<Esc>^", { desc = "Open line below" })
set("n", "<leader>O", "O<Esc>^", { desc = "Open line above" })

-- Copy the file path with `#L<line>`, for pointing agents at the exact line
set("n", "<leader>yf", function()
	Mildvii.editor.copy_path()
end, { desc = "Copy relative path with line" })
set("n", "<leader>yp", function()
	Mildvii.editor.copy_path(true)
end, { desc = "Copy absolute path with line" })
