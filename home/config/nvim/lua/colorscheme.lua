-- Colorscheme
local status_ok, _ = pcall(vim.cmd, "colorscheme deep-space")
if not status_ok then
	return
end

-- Transparent
local status_ok, transparent = pcall(require, "transparent")
if not status_ok then
	return
end

transparent.setup({
	enable = true,
	exclude = {},
})

