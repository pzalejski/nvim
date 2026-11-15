-- blink.cmp: completion menu. Enter accepts.
require("blink.cmp").setup({
	keymap = { preset = "enter" },
	completion = {
		-- Add brackets after accepting a function
		accept = { auto_brackets = { enabled = true } },
		documentation = { auto_show = true, auto_show_delay_ms = 200 },
		ghost_text = { enabled = true },
		menu = {
			draw = {
				-- Colorize the labels of language-server items with Treesitter
				treesitter = { "lsp" },
				components = {
					-- Kind icons from mini.icons, the shared icon set
					kind_icon = {
						text = function(ctx)
							local icon = MiniIcons.get("lsp", ctx.kind)
							return icon .. ctx.icon_gap
						end,
						highlight = function(ctx)
							local _, hl = MiniIcons.get("lsp", ctx.kind)
							return { { group = hl, priority = 20000 } }
						end,
					},
				},
			},
		},
	},
	cmdline = {
		completion = {
			-- The menu opens by itself for `:` commands only, with nothing preselected
			menu = {
				auto_show = function()
					return vim.fn.getcmdtype() == ":"
				end,
			},
			list = { selection = { preselect = false } },
		},
	},
})
