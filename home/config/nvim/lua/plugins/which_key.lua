-- Whichkey
local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

which_key.setup({
	icons = {
		breadcrumb = "»",
		separator = ">",
		group = "+",
	},
	window = {
		border = "single",
		margin = { 0, 0, 0, 0, },
		padding = { 0, 0, 0, 0, },
	},
	layout = {
		height = { min = 5, max = 15 },
		width = { min = 20, max = 50 },
		spacing = 1,
		align = "left",
	},
	show_help = false,
})

which_key.register(mappings, opts)
