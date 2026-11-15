-- nvim-treesitter (main branch): installs parsers. Highlighting and indent are started per buffer below.
require("nvim-treesitter").install({
	"bash",
	"c",
	"cmake",
	"cpp",
	"css",
	"diff",
	"gitignore",
	"go",
	"html",
	"http",
	"javascript",
	"jsdoc",
	"json",
	"lua",
	"luadoc",
	"luap",
	"markdown",
	"markdown_inline",
	"printf",
	"python",
	"query",
	"regex",
	"rust",
	"toml",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"xml",
	"yaml",
})

-- Start Treesitter highlighting and indent whenever a parser exists for the buffer's filetype
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("mildvii_treesitter", { clear = true }),
	callback = function(ev)
		local lang = vim.treesitter.language.get_lang(ev.match)
		if not lang or not vim.treesitter.language.add(lang) then
			return
		end
		vim.treesitter.start(ev.buf, lang)
		vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
