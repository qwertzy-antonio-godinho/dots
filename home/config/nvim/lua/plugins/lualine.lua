-- Lualine
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local function virtualenv()
	local _, name_with_path = pcall(os.getenv, "VIRTUAL_ENV")
	if name_with_path == nil then
		return ""
	end
	local venv = {};
	for match in (name_with_path .. "/"):gmatch("(.-)" .. "/") do
		table.insert(venv, match);
	end
	return venv[#venv]
end

lualine.setup({
	options = {
		icons_enabled = false,
		theme = "auto",
		component_separators = "|",
		section_separators = "",
	},
	sections = {
		lualine_a = {},
		lualine_b = {virtualenv, "branch", "diff", "diagnostics"},
		lualine_c = {
			{
				"aerial",
				sep = " > ",
				depth = nil,
				dense = false,
				dense_sep = ".",
				colored = true,
			}
		},
		lualine_x = {
			{
				"filename",
				path = 3,
			}
		},
		lualine_z = {
			{
				progress,
			}
		},
	},
})
