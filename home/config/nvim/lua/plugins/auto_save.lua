-- Autosave
local status_ok, autosave = pcall(require, "auto-save")
if not status_ok then
	return
end

autosave.setup({
	execution_message = {
		message = function()
			return ("")
		end,
	},
	trigger_events = {"TextChangedI"},
})
