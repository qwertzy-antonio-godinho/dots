-- NeoTree
local status_ok, neotree = pcall(require, "neo-tree")
if not status_ok then
	return
end

vim.api.nvim_set_hl(0, "NeoTreeGitAdded", {bg="Green"})
vim.api.nvim_set_hl(0, "NeoTreeGitConflict", {bg="Red"})
vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", {bg="Orange"})
vim.api.nvim_set_hl(0, "NeoTreeGitIgnored", {bg="Gray"})
vim.api.nvim_set_hl(0, "NeoTreeGitModified", {fg="Yellow"})
vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", {bg="Blue"})

neotree.setup({
	sources = {
		"filesystem",
		"git_status",
	},
	enable_git_status = false,
	source_selector = {
		winbar = true,
		statusline = false,
		tab_labels = {
			filesystem = "▎Files",
			buffers = "▎Buffers",
			git_status = "▎Git",
			diagnostics = "▎Diagnostics",
		},
	},
	close_if_last_window = true,
	window = {
		position = "right",
		mappings = {
        	["<2-LeftMouse>"] = "open_with_window_picker",
			["<enter>"] = "open_with_window_picker",
		},
	},
	popup_border_style = "rounded",
	default_component_configs = {
		icon = {
			folder_closed = "",
			folder_open = "",
			folder_empty = "",
			default = "≣",
		},
		git_status = {
			symbols = {
				added     = "A",
				modified  = "M",
				deleted   = "D",
				renamed   = "R",
				untracked = "?",
				ignored   = "-",
				unstaged  = "U",
				staged    = "S",
				conflict  = "‼",
			},
		},
	},
	enable_diagnostics = false,
	filesystem = {
		filtered_items = {
			visible = true,
			hide_gitignored = true,
			hide_dotfiles = false,
			hide_by_pattern = {
				"*/__pycache__",
				"*/.git",
				"*/.pytest_cache"
			},
		},
	},
})
