-- Custom lualine components
local M = {}

--- Name of the project root, shown only when it differs from the cwd
function M.root_name()
	local root = Mildvii.root.get()
	if root == vim.fs.normalize(vim.fn.getcwd()) then
		return ""
	end
	return "󱉭 " .. vim.fs.basename(root)
end

--- File path relative to the project root, shortened to `first/…/parent/file` when deep
function M.pretty_path()
	local name = vim.api.nvim_buf_get_name(0)
	if name == "" then
		return ""
	end
	name = vim.fs.normalize(name)

	local root = Mildvii.root.get()
	local path = vim.fs.relpath(root, name) or vim.fn.fnamemodify(name, ":~:.")

	local parts = vim.split(path, "/", { plain = true })
	if #parts > 3 then
		parts = { parts[1], "…", parts[#parts - 1], parts[#parts] }
	end
	path = table.concat(parts, "/")

	if vim.bo.modified then
		path = path .. " ●"
	end
	if vim.bo.readonly or not vim.bo.modifiable then
		path = path .. " 󰌾"
	end
	return path
end

--- Register being recorded into, e.g. `recording @q`
function M.recording()
	local reg = vim.fn.reg_recording()
	return reg ~= "" and ("recording @" .. reg) or ""
end

-- Neovim fills a section with no background, and the bubble edges, from
-- StatusLine, so StatusLine gets the editor's (Normal) background too. This is
-- scheduled because lualine resets highlights after the theme is built.
local function match_statusline_to_editor()
	local statusline = vim.api.nvim_get_hl(0, { name = "StatusLine", link = false })
	statusline.bg = vim.api.nvim_get_hl(0, { name = "Normal", link = false }).bg or "NONE"
	vim.api.nvim_set_hl(0, "StatusLine", statusline)
end

--- Bubbles-style lualine theme built from the palette in plugins/theme.lua.
--- Reads the file fresh each time, so it picks up a new palette after Omarchy rewrites it.
--- Falls back to lualine's auto theme when the theme file has no aether colors.
---@return table
local function build_theme()
	local path = vim.fn.stdpath("config") .. "/lua/mildvii/plugins/theme.lua"
	local ok, spec = pcall(dofile, path)
	local c = ok and type(spec) == "table" and type(spec[1]) == "table" and vim.tbl_get(spec[1], "opts", "colors")
	if not c then
		return require("lualine.utils.loader").load_theme("auto")
	end

	local function mode(color)
		return { a = { fg = c.darker_bg, bg = color, gui = "bold" } }
	end

	return {
		normal = {
			a = { fg = c.darker_bg, bg = c.accent, gui = "bold" },
			b = { fg = c.fg, bg = c.darker_bg },
			c = { fg = c.fg },
		},
		insert = mode(c.green),
		visual = mode(c.cyan),
		replace = mode(c.red),
		command = mode(c.magenta),
		inactive = {
			a = { fg = c.fg, bg = c.darker_bg },
			b = { fg = c.fg, bg = c.darker_bg },
			c = { fg = c.muted },
		},
	}
end

-- Let the status line show the terminal background, like the rest of the
-- editor. The middle sections' backgrounds are cleared on each theme lualine
-- builds, which it does again on every colorscheme change. The mode and
-- position sections keep their colours.
---@return table
function M.theme()
	vim.schedule(match_statusline_to_editor)

	local theme = build_theme()
	for _, mode in pairs(theme) do
		for _, section in ipairs({ "b", "c", "x", "y" }) do
			if mode[section] then
				mode[section].bg = "NONE"
			end
		end
	end
	return theme
end

return M
