-- Dashboard pieces: the Samurai logo (Cyberpunk 2077), colored from the theme, and the footer.
local M = {}

-- Braille art converted from a photo of the neon sign. `mask` has one letter per
-- character of `art`: `r` for the red neon, `w` for the white neon.
local art = [[
                                     ⢀⡄
        ⡀                         ⢀⣠⠤⢞⡇         ⢠⡀
       ⠈⣿⡀            ⢀         ⣠⠞⢉⡤⠖⠋    ⣴⡀    ⡼⡇
       ⢰⣿⡇          ⣰⢦⣾⠃       ⡼⠁⢠⠎⢰⡄    ⢀⣿⡇  ⣠⠊⣰⠃
       ⢻⢸⡇         ⣼⡟⢸⣇   ⢀⣴⠖ ⢠⡇ ⠘⢦⣼⡇   ⢠⠎⡸⠃  ⣯⠏
       ⠘⣿⡇         ⣇⠹⡄⠉   ⠘⡟⣆ ⢸⠃   ⣸⣄⣠⣾⠁⠿⠋ ⢀⡀ ⠋      ⣤⡀
        ⠈⠷⣀    ⣶⡀  ⢹⡀⠹⡄ ⢸⣧⡴⠃⠹⠶⠋   ⢰⢟⣬⡅⡿ ⢀⣴⠏⣼⣇⡄     ⢀⣞⡟⠁
   ⣀      ⢹⣧⡀  ⠙⢽⡄⢠⡄⢹⡄⣷⡄⣼⠁        ⢠⣿⣾⠟⠁⢠⠏⢧⢸⡟⢸⢷  ⢠⡿ ⢸⠏
   ⣿⡄  ⢷⡄⢰⡄⠳⡌⢣⡀ ⡄⠁⢈⣿⣼⠰⣿⣇⡇         ⠸⠃⢧⣤⠔⠃ ⢸⠏⣡⠋⢸  ⣿⣧
   ⢻⣳⡀ ⠘⡿⣽⡷⣄⢹ ⢷ ⣷⣠⡞⡏⡇ ⠘⠛     ⣸⡇⢀⣀⣴⣿   ⣠⡀ ⡏ ⣇⡠⢯⡆ ⢻⢹⡀
    ⢻⣧  ⣇⠈⠑⣾⣎⣇⢸ ⢻⢿ ⠹⣧ ⢠⣄⢠⡀⢀⣴⠟⢻⣷⠟⠋⣹⡇  ⡼⡙⡇ ⢷⣼⡏⣀⡿⡇ ⢸⣿
 ⢠⡀  ⠉⢠⣄⠈⠻⡴⣣⢿⣼⣾⡤⢼⣏  ⠙⢷⡸⣌⢻⣿⣾⠃ ⠸⠇ ⣠⣟⣤⡄ ⠋⠙⠃⠈⢻⣯⣷⡿⠇⢹⠠⠟⠁
 ⠸⣧   ⠈⣿⡄⢠⠖⣃⣤⣀⣛⡃ ⢻⡆⣾⣼⣧ ⠈⢻⡇⠁ ⢀⡄ ⢰⣿⠟⠋   ⣀⣤⣄⡸⣿⣾⡽⣠⠏
    ⢲⣄⣰⢻⣿⡞⣟⣷⢤⣠⢞⣻⢿⡿⣇⣿⣿⡟ ⣀  ⣾⣠⣿⠁ ⠻⣯   ⣠⠞⠁  ⣷⢿⣿⣳⡿⡿
    ⠸⣿⣿⠸⠘⡇⠻⣞⠷⣿⣿⣿⢿⣦⠘⢻⣟⣁⣼⠏⣰⡆⢯⢯⣿⣄    ⣠⣞⡁    ⡿⢸⣿⣿⡇⡇
     ⣿⠁ ⢠⠽⠆⢈⣓⢻⣿⣿⢾⡿⣆⣠⣽⣿⢷⠶⠟⠁⠈⠣⣝⡛⡷⠶⠖⠛⢷⡿⠃   ⣰⠃⣼⢷⢿⣷⠇
   ⢠⡀⢻⡀⢠⡿⢰⡋⠺⣞⠻⣯⣿⣿⡷⠏⡳⢿⠟⢿⡥⡄  ⣤⣿⣿⣿⣷⣦⣤⣀⣀⣀⣀⡤⣞⣥⡾⢋ ⡿⢟⡀
    ⢻⣷⠙⠮⣧⣯⡛⣿⣶⣯⡙⠛⠛⠋⢉⣩⢧⢶⢶⡿⣓⣦ ⠐⠻⣷⣝⠻⣯⣝⣛⠛⠿⠟⠛⢛⡭⣶⠟⡴⢣⢿⣝⢦
     ⢰⡒⣆⠉⢻⡏⠛⠿⠭⠿⠿⠟⠉⢩⠲⣜⣜⢄⣸⠟⡿   ⠈⠳⣝⢦⡙⠪⣭⣉⣩⠭⢟⣻⣵⡟⠓⣌⢻⡻⣿⣳⡀
      ⠙⡿ ⠈⠁   ⢀⡴⠲⠶⢋⣀⣸⡏⢠⠇⣎⣴⡶ ⡤⠒⢳⣼⡇⠙⠦⢤⣀  ⣾⡃⠘⢿⣦⣼⠧⣷⣽⣏⡇
          ⣰⡄ ⠠⣏⣴⠶⣦⣼⣟⠋ ⢸⣺⣿⡁⢀⣠⠇⠴⢿⣫⢖⣻⣿⣟⡻⣷⣸⠃⠙⢦⣠⡿⣌⡙⢲⠿⡞
          ⠛⠃ ⢀⡴⠃ ⠘⣾⠛⣿⣻⠿⣿⡌⢹⠛⠶⠶⠒⣫⠖⡿⠉⠉⠙⣿⣹⡋    ⠓⠤⣭⣥⠞⠁
         ⢀⣠⠤⠖⠋  ⢀⣴⡉⠛⠉⠉⠛⠙⠁⠈⠉⠉⠉⠉ ⢀⣙⢦⡀ ⠈⠻⣄⡀
       ⠾⢯⣭⣤⣤⣤⣤⣴⠚⠁⣿⠙⢦⣠⣤⣄⣀⣠⣤⣤⣀⣀⣤⣠⠞⢸ ⠙⣲⣤⣀⣀⠉⠙⠒⣦⣤⠄
            ⠙⢦⠈⠧⣄⣘⣲⡾⠟⣋⣩⡤⠴⠶⠤⣄⡈⠙⠿⣶⣚⣀⣠⠇⣹⠃⠉⠉⠉⠉⠉
             ⠈⠓⠦⣤⣬⣤⠶⢾⣷⠴⠒⠲⠖⠒⠲⣽⡷⢶⣤⣈⣅⣤⠞⠁
                 ⠈⠳⢴⡟⠁      ⠘⣷⡤⠞
                    ⠙⠦⣤⣤⡼⣧⣤⡤⠖⠋
]]

local mask = [[
                                     rr
        r                         rrrrr         rr
       rrr            r         rrrrrr    rr    rr
       rrr          rrrr       rrrrrr    rrr  rrrr
       rrr         rrrr   rrr rr rrrr   rrrr  rr
       rrr         rrrr   rrr rr   rrrrrrr rr r      rr
        rrr    rr  rrrr rrrrrrr   rrrrr rrrrrr     rrrr
   r      rrr  rrrrrrrrrrr        rrrrrrrrrrrr  rr rr
   rr  rrrrrrrr rrrrrrrrr         rrrrrr rrrrr  rr
   rrr rrrrrr r rrrrr rr     rrrrrr   rr r rrrr rrr
    rr  rrrrrrr rr rr rrrrrrrrrrrrr  rrr rrrrrr rr
 rr  rrrrrrwrwrwwr  rrrrrrrr rr rrrr rrrrrrrrrrrrr
 rr   rrrwwwwwww wrrrr rrrr rr rrrr   rrrrrrrrr
    rrrrrrwwwwwwwwrrrr r  rrrr rr   rrr  rrrrrr
    rrrrrrwwwwwwwwrrrrrrrrrrrr    rrr    rrrrrr
     rr rrrwwwwwrwwwrrrrrrrrrrrrrrrrr   rrrrrrr
   rrrrrrwwwwwwwwwwwrrrrr  rrrrrrrrrrrrrrrr rrw
    rrrrrwwwwwwwwwwwwwrrrr rrrrrrrrrrrrrrrrrrwww
     rrrrrrwwwwwwwwwwwwrrr   rrrrrrrrrrrrrrwwwwwww
      rr rr   wwwwwwwwwwrrr rrrrrrrrr  rwwwwwwwwww
          rr wwwwwwww wrrrrrrrrrrrrrrrrrwwwwwwwww
          rr www wwwwwwwwrrrrrrrwwwwrrr    wwwwww
         wwwww  wwwwwwwwwrrrrr wwww wwww
       wwwwwwrwwwwwwwwwrrrrrrwwww wwwwwwwwwww
            rrrrrrwwrrrrrrrrrrrrwrrrrrwwwww
             rrrrrrrrrrrrrrrrrrrrrrrr
                 rrrrr      rrrr
                    rrrrrrrrrr
]]

--- Rows in the logo, for lining up the other pane with it
M.logo_height = #vim.split(art, "\n", { plain = true, trimempty = true })

-- The red parts use the theme's red; the white parts use its foreground
local hl = { r = "MildviiDashboardLogo", w = "MildviiDashboardLogoAlt" }

--- Link the logo groups to theme groups. Rerun on every colorscheme change,
--- because loading a colorscheme clears groups it doesn't define.
function M.set_hl()
	vim.api.nvim_set_hl(0, hl.r, { link = "DiagnosticError" })
	vim.api.nvim_set_hl(0, hl.w, { link = "Normal" })
end

--- The logo as snacks dashboard text: runs of characters with their highlight
---@return snacks.dashboard.Text[]
function M.logo()
	local art_lines = vim.split(art, "\n", { plain = true, trimempty = true })
	local mask_lines = vim.split(mask, "\n", { plain = true, trimempty = true })
	local width = 0
	for _, line in ipairs(art_lines) do
		width = math.max(width, vim.fn.strchars(line))
	end

	local text = {}
	for i, line in ipairs(art_lines) do
		local m = mask_lines[i] or ""
		local run, run_hl, col = "", nil, 0
		for ch in line:gmatch("[%z\1-\127\194-\244][\128-\191]*") do
			col = col + 1
			local h = hl[m:sub(col, col)]
			if h ~= run_hl and run ~= "" then
				text[#text + 1] = { run, hl = run_hl }
				run = ""
			end
			run, run_hl = run .. ch, h
		end
		-- Pad every row to the same width, so centering keeps the rows lined up
		run = run .. string.rep(" ", width - col)
		if i < #art_lines then
			run = run .. "\n"
		end
		text[#text + 1] = { run, hl = run_hl }
	end
	return text
end

local startup_ms ---@type number?

--- Footer: plugin count and startup time. The built-in `startup` section needs lazy.nvim.
---@return snacks.dashboard.Section
function M.footer()
	startup_ms = startup_ms or (vim.uv.hrtime() - (vim.g.mildvii_start or vim.uv.hrtime())) / 1e6
	return {
		align = "center",
		text = {
			{ "⚡ Neovim loaded ", hl = "footer" },
			{ tostring(#vim.pack.get()), hl = "special" },
			{ " plugins in ", hl = "footer" },
			{ ("%.2fms"):format(startup_ms), hl = "special" },
		},
	}
end

return M
