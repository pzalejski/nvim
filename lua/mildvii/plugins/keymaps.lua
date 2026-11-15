-- Keymaps that use plugins. Group files hold no keymaps.
local set = vim.keymap.set

-- snacks.words: jump between occurrences of the word under the cursor
set("n", "]]", function()
	Snacks.words.jump(vim.v.count1)
end, { desc = "Next reference" })
set("n", "[[", function()
	Snacks.words.jump(-vim.v.count1)
end, { desc = "Previous reference" })

-- snacks.picker
set("n", ";f", function()
	Snacks.picker.files()
end, { desc = "Find files" })
set("n", ";r", function()
	Snacks.picker.grep()
end, { desc = "Live grep" })
set("n", ";;", function()
	Snacks.picker.resume()
end, { desc = "Resume last picker" })
set("n", [[\\]], function()
	Snacks.picker.buffers()
end, { desc = "Buffers" })
set("n", ";e", function()
	Snacks.picker.diagnostics()
end, { desc = "Diagnostics" })
set("n", ";n", function()
	Snacks.picker.notifications()
end, { desc = "Notification history" })
set("n", ";h", function()
	Snacks.picker.git_diff()
end, { desc = "Git hunks" })

-- oil: centered float with a live preview
set("n", "sf", function()
	require("oil").open_float(nil, { preview = {} })
end, { desc = "File explorer" })

-- conform: format now (works without a language server)
set({ "n", "x" }, "<leader>f", function()
	require("conform").format()
end, { desc = "Format" })

--- TypeScript: jump past the `.d.ts` to the real source with vtsls's goToSourceDefinition
---@param client vim.lsp.Client
local function source_definition(client)
	local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
	client:exec_cmd({
		title = "Go to source definition",
		command = "typescript.goToSourceDefinition",
		arguments = { params.textDocument.uri, params.position },
	}, { bufnr = 0 }, function(err, result)
		if err or not result or vim.tbl_isempty(result) then
			return vim.notify("No source definition found", vim.log.levels.WARN)
		end
		if #result == 1 then
			return vim.lsp.util.show_document(result[1], client.offset_encoding, { focus = true })
		end
		vim.fn.setqflist({}, " ", {
			title = "Source definitions",
			items = vim.lsp.util.locations_to_items(result, client.offset_encoding),
		})
		Snacks.picker.qflist()
	end)
end

-- Language-server keymaps, set per buffer when a server attaches
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("mildvii_lsp_keymaps", { clear = true }),
	callback = function(ev)
		local function map(mode, lhs, rhs, desc, opts)
			set(mode, lhs, rhs, vim.tbl_extend("force", { buffer = ev.buf, desc = desc }, opts or {}))
		end

		-- Navigation through the picker
		map("n", "gd", function()
			Snacks.picker.lsp_definitions()
		end, "Go to definition")
		map("n", "gD", function()
			Snacks.picker.lsp_declarations()
		end, "Go to declaration")
		map("n", "gy", function()
			Snacks.picker.lsp_type_definitions()
		end, "Go to type definition")
		-- nowait: don't wait for Neovim's default grr/gra/grn/… mappings
		map("n", "gr", function()
			Snacks.picker.lsp_references()
		end, "References", { nowait = true })
		map("n", "gI", function()
			local vtsls = vim.lsp.get_clients({ bufnr = ev.buf, name = "vtsls" })[1]
			if vtsls then
				source_definition(vtsls)
			else
				Snacks.picker.lsp_implementations()
			end
		end, "Go to source definition / implementation")
		map("n", ";c", function()
			Snacks.picker.lsp_incoming_calls()
		end, "Incoming calls")

		-- Docs
		map("n", "K", vim.lsp.buf.hover, "Hover docs")
		map("n", "gK", vim.lsp.buf.signature_help, "Signature help")
		map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help")

		-- Code actions and refactors
		map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "Code actions")
		map("n", "<leader>cr", vim.lsp.buf.rename, "Rename symbol")
		map("n", "<leader>cR", "<cmd>RenameFile<CR>", "Rename file (updates imports)")
		map("n", "<leader>cl", "<cmd>checkhealth vim.lsp<CR>", "LSP info")
	end,
})

-- gitsigns
set("n", "<leader>gb", function()
	require("gitsigns").blame_line()
end, { desc = "Blame line" })
set("n", "<leader>gB", function()
	require("gitsigns").blame()
end, { desc = "Blame buffer" })
set("n", "<leader>go", function()
	Mildvii.git.open_line_commit()
end, { desc = "Open file at the line's last commit" })
set("n", "<leader>gs", function()
	local gitsigns = require("gitsigns")
	-- Stage the buffer, or unstage it when nothing unstaged is left
	if vim.tbl_isempty(gitsigns.get_hunks(0) or {}) then
		gitsigns.reset_buffer_index()
	else
		gitsigns.stage_buffer()
	end
end, { desc = "Stage / unstage buffer" })
set("n", "<leader>gh", function()
	-- Stages the hunk, or unstages it when the cursor is on a staged hunk
	require("gitsigns").stage_hunk()
end, { desc = "Stage / unstage hunk" })
