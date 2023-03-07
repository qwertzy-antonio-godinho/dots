-- Indent blankline
local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
	return
end

indent_blankline.setup({
	char_blankline = "┆",
	filetype_exclude = { "help", "alpha", "dashboard", "Trouble", "lazy", "startify", },
	show_trailing_blankline_indent = false,
	show_current_context = true,
	show_current_context_start = true,
})
