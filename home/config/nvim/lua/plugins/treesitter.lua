-- Treesitter install
local status_ok, treesitter_install = pcall(require, "nvim-treesitter.install")
if not status_ok then
	return
end

-- Treesitter config
local status_ok, treesitter_config = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

-- Treesitter context
local status_ok, treesitter_context = pcall(require, "treesitter-context")
if not status_ok then
	return
end

treesitter_install.update({
	with_sync = true,
})

treesitter_config.setup({
	ensure_installed = {
		"python",
		"bash",
		"proto",
		"markdown",
		"yaml",
		"toml",
		"help",
		"ini",
		"diff",
		"dockerfile",
		"json",
		"regex",
	},
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
		use_languagetree = true,
	},
	textobjects = {
		lsp_interop = {
			enable = true,
			border = "single",
			floating_preview_opts = {},
			peek_definition_code = {
				["<leader>df"] = "@function.outer",
				["<leader>dF"] = "@class.outer",
			},
		},
	},
})

treesitter_context.setup()
