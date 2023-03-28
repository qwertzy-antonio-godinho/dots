-- Aerial
local status_ok, aerial = pcall(require, "aerial")
if not status_ok then
	return
end

aerial.setup({
	backends = { "lsp", "treesitter", },
	layout = {
		default_direction = "right",
	},
	highlight_on_hover = false,
	show_guides = true,
	lsp = {
		diagnostics_trigger_update = true,
		update_when_errors = true,
	},
})

vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
