-- Trouble
local status_ok, trouble = pcall(require, "trouble")
if not status_ok then
	return
end

trouble.setup({
	position = "bottom",
	mode = "workspace_diagnostics", 
	icons = false,
	padding = false,
	indent_lines = false,
	signs = {
		error = "E",
		warning = "W",
		hint = "H",
		information = "I",
	},
	use_diagnostic_signs = false,
})
