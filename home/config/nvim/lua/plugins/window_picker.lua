-- Window picker
local status_ok, window_picker = pcall(require, "window-picker")
if not status_ok then
	return
end

window_picker.setup()
