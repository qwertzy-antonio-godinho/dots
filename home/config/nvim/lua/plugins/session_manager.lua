-- Session Manager
local status_ok, session_manager = pcall(require, "session_manager")
if not status_ok then
	return
end

-- Plenary
local status_ok, plenary = pcall(require, "plenary.path")
if not status_ok then
	return
end

local path = plenary

session_manager.setup({
	sessions_dir = path:new(vim.fn.stdpath("data"), "sessions"),
	path_replacer = "__",
	colon_replacer = "++",
	autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir,
	autosave_last_session = true,
	autosave_ignore_not_normal = true,
	autosave_ignore_filetypes = {
		"gitcommit",
	},
	autosave_ignore_buftypes = {},
	autosave_only_in_session = false,
	max_path_length = 80,
})
