-- Lualine
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

lualine.setup({
	options = {
		icons_enabled = false,
		theme = "auto",
		component_separators = "|",
		section_separators = "",
	},
	sections = {
		lualine_x = {
			{
				"filename",
				path = 3,
			}
		},
		lualine_b = {"branch", "diff", "diagnostics"},
		lualine_c = { {
			"aerial",
			sep = " > ",
			depth = nil,
			dense = false,
			dense_sep = ".",
			colored = true,
		} },
	},
})
