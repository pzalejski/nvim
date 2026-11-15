---@type vim.lsp.Config
return {
	-- In the Neovim config, teach lua_ls about the Neovim runtime and installed plugins
	on_init = function(client)
		local root = client.workspace_folders and client.workspace_folders[1] and client.workspace_folders[1].name
		if root ~= vim.fn.stdpath("config") then
			return
		end
		local library = { vim.env.VIMRUNTIME }
		for _, plugin in ipairs(vim.pack.get()) do
			table.insert(library, plugin.path)
		end
		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua or {}, {
			runtime = { version = "LuaJIT", path = { "lua/?.lua", "lua/?/init.lua" } },
			workspace = { checkThirdParty = false, library = library },
		})
		client:notify("workspace/didChangeConfiguration", { settings = client.config.settings })
	end,
	settings = {
		Lua = {
			-- stylua formats Lua (through conform.nvim)
			format = { enable = false },
		},
	},
}
