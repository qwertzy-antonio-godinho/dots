-- Colorscheme

local status_ok, _ = pcall(vim.cmd, "colorscheme tokyodark")
if not status_ok then
	return
else
	vim.g.tokyodark_transparent_background = true
	vim.g.tokyodark_enable_italic_comment = false
	vim.g.tokyodark_enable_italic = false
	vim.g.tokyodark_color_gamma = "1.0"
end
