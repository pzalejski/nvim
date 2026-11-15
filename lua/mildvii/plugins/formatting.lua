-- conform.nvim: formatting and format-on-save. Mason installs the formatters (plugins/lsp.lua).
local util = require("conform.util")

local oxfmt = { "oxfmt" }

require("conform").setup({
	formatters_by_ft = {
		javascript = oxfmt,
		typescript = oxfmt,
		javascriptreact = oxfmt,
		typescriptreact = oxfmt,
		json = oxfmt,
		jsonc = oxfmt,
		css = oxfmt,
		scss = oxfmt,
		less = oxfmt,
		html = oxfmt,
		markdown = oxfmt,
		mdx = oxfmt,
		yaml = oxfmt,
		lua = { "stylua" },
		python = { "ruff_format" },
		sh = { "shfmt" },
		bash = { "shfmt" },
		fish = { "fish_indent" },
		go = { "gofmt" },
	},
	formatters = {
		-- Oxfmt runs only in projects with an Oxfmt config, so projects using Prettier keep
		-- their own workflow. Unlike conform's default, a vite.config.* alone doesn't count.
		oxfmt = {
			cwd = util.root_file({ ".oxfmtrc.json", ".oxfmtrc.jsonc", "oxfmt.config.ts" }),
			require_cwd = true,
		},
	},
	-- Never fall back to LSP formatting
	default_format_opts = { lsp_format = "never", timeout_ms = 1000 },
	-- `:ToggleFormatter` (config/commands.lua) turns this off per buffer
	format_on_save = function(buf)
		if vim.b[buf].disable_autoformat then
			return
		end
		return { lsp_format = "never", timeout_ms = 1000 }
	end,
})
