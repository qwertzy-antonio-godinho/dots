-- Aerial
local status_ok, aerial = pcall(require, "aerial")
if not status_ok then
	return
end

aerial.setup({
	layout = {
		default_direction = "left",
	},
	highlight_on_hover = false,
	show_guides = true,
	lsp = {
		diagnostics_trigger_update = true,
		update_when_errors = true,
	},
})
