-- Scrollview
local status_ok, scrollview = pcall(require, "scrollview")
if not status_ok then
	return
end

vim.g.scrollview_character = "▎"

scrollview.setup({
	column = 1,
})
