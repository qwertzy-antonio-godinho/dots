-- CMP
local status_ok, cmp = pcall(require, "cmp")
if not status_ok then
	return
end

cmp.setup({
	enabled = function()
		return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
		or require("cmp_dap").is_dap_buffer()
	end,
	window = {
		completion = {
			border = "single",
			winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
		},
		documentation = {
			border = "single",
		},
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "buffer" },
	},
	mapping = cmp.mapping.preset.insert {
		["<CR>"] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "s" }),
	},
})

cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
	sources = {
		{ name = "dap" },
	},
})
