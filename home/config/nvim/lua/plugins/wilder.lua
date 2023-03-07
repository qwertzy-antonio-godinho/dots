-- Wilder
local status_ok, wilder = pcall(require, "wilder")
if not status_ok then
	return
end

wilder.setup({ modes = { ":", "/", "?" } })

wilder.set_option("pipeline", {
	wilder.branch(
		wilder.cmdline_pipeline(),
		wilder.search_pipeline()
	),
})

wilder.set_option("renderer", wilder.popupmenu_renderer(
	wilder.popupmenu_palette_theme({
		border = "rounded",
		max_height = "90%",
		min_height = "90%",
		prompt_position = "top",
		reverse = 0,
	})
))
