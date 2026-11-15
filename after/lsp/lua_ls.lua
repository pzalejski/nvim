---@type vim.lsp.Config
return {
	-- In the Neovim config, add the Neovim runtime and every plugin on the runtimepath
	-- to the library, so the server understands Neovim and plugin APIs
	on_init = function(client)
		local root = client.workspace_folders and client.workspace_folders[1] and client.workspace_folders[1].name
		if root ~= vim.fn.stdpath("config") then
			return
		end
		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua or {}, {
			workspace = { library = vim.api.nvim_get_runtime_file("", true) },
		})
		client:notify("workspace/didChangeConfiguration", { settings = client.config.settings })
	end,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT", path = { "lua/?.lua", "lua/?/init.lua" } },
			-- Don't keep asking to index third-party libraries
			workspace = { checkThirdParty = false },
			diagnostics = {
				globals = { "vim" },
				-- Neovim's extensible config tables make missing-fields mostly noise
				disable = { "missing-fields" },
			},
			-- Parameter types only
			hint = {
				enable = true,
				paramType = true,
				paramName = "Disable",
				setType = false,
				arrayIndex = "Disable",
				await = false,
				semicolon = "Disable",
			},
			-- stylua formats Lua (through conform.nvim)
			format = { enable = false },
		},
	},
}
