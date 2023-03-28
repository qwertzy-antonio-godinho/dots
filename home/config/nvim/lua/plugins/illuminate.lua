-- Illuminate
local status_ok, illuminate = pcall(require, "illuminate")
if not status_ok then
	return
else
	vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
	vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
	vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
	vim.cmd("hi IlluminatedWordText guibg=#525252")
	vim.cmd("hi IlluminatedWordRead guibg=#525252")
	vim.cmd("hi IlluminatedWordWrite guibg=#525252")

	illuminate.configure({
		providers = {
			"treesitter",
			"regex",
		},
		min_count_to_highlight = 2,
	})
end
