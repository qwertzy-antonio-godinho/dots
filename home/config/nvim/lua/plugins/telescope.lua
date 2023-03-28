-- Telescope
local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local status_ok, telescope_builtin = pcall(require, "telescope.builtin")
if not status_ok then
	return
end

telescope.setup({
	extensions = {
		["ui-select"] = { require("telescope.themes").get_dropdown {} },
		["dap"] = { require("telescope.themes").get_dropdown {} },
	},
	defaults = {
		layout_strategy = "vertical",
		layout_config = {
			horizontal = {
				mirror = false,
				prompt_position = "top",
				preview_width = 0.4,
			},
			vertical = {
				mirror = true,
				prompt_position = "top",
				preview_height = 0.7,
			},
			width = 0.8,
			height = 0.9,
			preview_cutoff = 10,
		},
		border = {},
		borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
		path_display = { "smart" },
		file_ignore_patterns = {
			".git/",
			"target/",
			"docs/",
			"vendor/*",
			"%.lock",
			"__pycache__/*",
			"%.sqlite3",
			"%.ipynb",
			"node_modules/*",
			"%.jpg",
			"%.jpeg",
			"%.png",
			"%.svg",
			"%.otf",
			"%.ttf",
			"%.webp",
			".dart_tool/",
			".github/",
			".gradle/",
			".idea/",
			".settings/",
			".vscode/",
			"__pycache__/",
			"build/",
			"env/",
			"gradle/",
			"node_modules/",
			"%.pdb",
			"%.dll",
			"%.class",
			"%.exe",
			"%.cache",
			"%.ico",
			"%.pdf",
			"%.dylib",
			"%.jar",
			"%.docx",
			"%.met",
			"smalljre_*/*",
			".vale/",
			"%.burp",
			"%.mp4",
			"%.mkv",
			"%.rar",
			"%.zip",
			"%.7z",
			"%.tar",
			"%.bz2",
			"%.epub",
			"%.flac",
			"%.tar.gz",
		},
	}
})

telescope.load_extension("dap")
telescope.load_extension("ui-select")

vim.keymap.set("n", "<leader>ds", telescope_builtin.lsp_document_symbols, { desc = "[D]ocument [S]ymbols" })
vim.keymap.set("n", "<leader>gr", telescope_builtin.lsp_references, { desc = "[G]oto [R]eferences" })
vim.keymap.set("n", "<leader>sf", telescope_builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sg", telescope_builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", telescope_builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>")
vim.keymap.set("n", "<leader>k", telescope_builtin.keymaps, { desc = "[K]eymaps" })
vim.keymap.set("n", "<leader>gcf", "<cmd>Telescope git_bcommits<cr>")
vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>")
vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>")
vim.keymap.set("n", "<leader>/", function()
	telescope_builtin.current_buffer_fuzzy_find(
		require("telescope.themes").get_dropdown {
			previewer = false,
		}
	)
end, { desc = "[/] Fuzzily search in current buffer]" })
