-- Colorscheme
local status_ok, _ = pcall(vim.cmd, "colorscheme deep-space")
if not status_ok then
	return
end

-- Transparent
local status_ok, transparent = pcall(require, "transparent")
if not status_ok then
	return
else
	transparent.setup({
		enable = true,
		exclude = {},
	})
end

-- Mason
local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
else
	mason.setup({
	})
end

-- Mason tool installer
local status_ok, mason_tool_installer = pcall(require, "mason-tool-installer")
if not status_ok then
	return
else
	mason_tool_installer.setup({
		ensure_installed = {
			"python-lsp-server",
			"flake8",
			"black",
			"isort",
			"debugpy",
		},
		auto_update = true,
		vim.api.nvim_create_autocmd("User", {
			pattern = "MasonToolsUpdateCompleted",
			callback = function()
				vim.schedule(function()
					print "mason-tool-installer has finished"
				end
				)
			end,
		})
	})
end

-- Mason LSPconfig
local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
	return
else
	local servers = {}
	mason_lspconfig.setup({
		ensure_installed = vim.tbl_keys(servers),
	})
	mason_lspconfig.setup_handlers({
		function(server_name)
			require("lspconfig")[server_name].setup {
				capabilities = capabilities,
				on_attach = on_attach,
				settings = servers[server_name],
			}
		end,
	})
end

-- CMP
local status_ok, cmp = pcall(require, "cmp")
if not status_ok then
	return
else
	cmp.setup({
		sources = {
			{ name = "nvim_lsp" },
			{ name = "path" },
			{ name = "nvim_lsp_signature_help" },
			{ name = "buffer" },
		},
		mapping = cmp.mapping.preset.insert {
			["<CR>"] = cmp.mapping.confirm {
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			},
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end, { "i", "s" }),
		},
	})
end

-- LSP config
local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
else
	local language_servers = lspconfig.util.available_servers()
	for _, ls in ipairs(language_servers) do
		lspconfig[ls].setup {
			capabilities = capabilities,
			on_attach = function(client, bufnr)
			end
		}
	end
end

-- CMP LSP
local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
	return
else
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true
	}
end

-- Fidget
local status_ok, fidget = pcall(require, "fidget")
if not status_ok then
	return
else
	fidget.setup({
	})
end

-- Window picker
local status_ok, window_picker = pcall(require, "window-picker")
if not status_ok then
	return
else
	window_picker.setup({
	})
end

-- Bufferline
local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
else
	bufferline.setup({
		options = {
			offsets = {
				{ filetype = "neo-tree", text = "Explorer", },
				{ filetype = "dapui", text = "Debug", },
				{ filetype = "Trouble",  text = "Problems", },
				{ filetype = "aerial",   text = "Symbols", },
			},
			custom_filter = function(buf_number, buf_numbers)
				local buf_name = vim.fn.bufname(buf_number)
				if string.find(buf_name, "fugitive") then
					return false
				end

				local filetype = vim.bo[buf_number].filetype
				if filetype == "qf" or filetype == "" then
					return false
				end
				return true
			end
		},
	})
end

-- Autosave
local status_ok, autosave = pcall(require, "auto-save")
if not status_ok then
	return
else
	autosave.setup({
		execution_message = {
			message = function()
				return ("")
			end,
		},
		trigger_events = {"TextChangedI"},
	})
end

-- Indent blankline
local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
	return
else
	indent_blankline.setup({
		char_blankline = "┆",
		filetype_exclude = { "help", "alpha", "dashboard", "Trouble", "lazy", "startify", },
		show_trailing_blankline_indent = false,
		show_current_context = true,
		show_current_context_start = true,
	})
end

-- Scrollview
local status_ok, scrollview = pcall(require, "scrollview")
if not status_ok then
	return
else
	vim.g.scrollview_character = "▎"
	scrollview.setup({
		column = 1,
	})
end

-- Wilder
local status_ok, wilder = pcall(require, "wilder")
if not status_ok then
	return
else
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
end

-- UFO Code fold
local status_ok, ufo = pcall(require, "ufo")
if not status_ok then
	return
else
	local handler = function(virtText, lnum, endLnum, width, truncate)
	local newVirtText = {}
	local suffix = ("  %d "):format(endLnum - lnum)
	local sufWidth = vim.fn.strdisplaywidth(suffix)
	local targetWidth = width - sufWidth
	local curWidth = 0
	for _, chunk in ipairs(virtText) do
		local chunkText = chunk[1]
		local chunkWidth = vim.fn.strdisplaywidth(chunkText)
		if targetWidth > curWidth + chunkWidth then
			table.insert(newVirtText, chunk)
		else
			chunkText = truncate(chunkText, targetWidth - curWidth)
			local hlGroup = chunk[2]
			table.insert(newVirtText, { chunkText, hlGroup })
			chunkWidth = vim.fn.strdisplaywidth(chunkText)
			if curWidth + chunkWidth < targetWidth then
				suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
			end
			break
		end
		curWidth = curWidth + chunkWidth
	end
	table.insert(newVirtText, { suffix, "MoreMsg" })
		return newVirtText
	end
	ufo.setup({ 
		fold_virt_text_handler = handler,
		provider_selector = function(bufnr, filetype, buftype)
			return { "treesitter", "indent" }
		end
	})
end

-- Gitsigns
local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
	return
else
	gitsigns.setup({
		signs = {
			add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
			change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr",
				linehl = "GitSignsChangeLn" },
			delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr",
				linehl = "GitSignsDeleteLn" },
			topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr",
				linehl = "GitSignsDeleteLn" },
			changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr",
				linehl = "GitSignsChangeLn" },
			untracked = { text = "┆" },
		},
		current_line_blame_formatter = "<author>, <author_time:%Y/%m/%d> - <summary>",
		current_line_blame = true,
		watch_gitdir = {
			interval = 700,
			follow_files = true
		},
		preview_config = {
			border = "rounded",
		},
	})
end

-- Diffview
local status_ok, diffview = pcall(require, "diffview")
if not status_ok then
	return
else
	diffview.setup({
		show_help_hints = false,
	})
end

-- Aerial
local status_ok, aerial = pcall(require, "aerial")
if not status_ok then
	return
else
	aerial.setup({
		layout = {
			default_direction = "left",
		},
		highlight_on_hover = false,
		show_guides = true,
		lsp = {
			diagnostics_trigger_update = true,
			update_when_errors = true,
		},
	})
end

-- Lualine
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
else
	lualine.setup({
		options = {
			icons_enabled = false,
			theme = "auto",
			component_separators = "|",
			section_separators = "",
		},
		sections = {
			lualine_x = {
				{
					"filename",
					path = 3,
				}
			},
			lualine_b = {"branch", "diff", "diagnostics"},
			lualine_c = { {
				"aerial",
				sep = " > ",
				depth = nil,
				dense = false,
				dense_sep = ".",
				colored = true,
			} },
		},
	})
end

-- NeoTree
local status_ok, neotree = pcall(require, "neo-tree")
if not status_ok then
	return
else
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
end

-- Trouble
local status_ok, trouble = pcall(require, "trouble")
if not status_ok then
	return
else
	trouble.setup({
		position = "bottom",
		icons = false,
		padding = false,
	})
end

-- Treesitter install
local status_ok, treesitter_install = pcall(require, "nvim-treesitter.install")
if not status_ok then
	return
else
	treesitter_install.update({
		with_sync = true,
	})
end

-- Treesitter config
local status_ok, treesitter_config = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
else
	treesitter_config.setup({
		ensure_installed = { 
			"python", 
			"bash", 
			"proto", 
			"markdown", 
			"lua", 
			"yaml", 
			"toml", 
			"help", 
			"vim", 
			"ini", 
			"diff", 
			"dockerfile", 
			"json", 
			"regex", 
		},
		highlight = { enable = true },
		indent = { enable = true },
		textobjects = {
			lsp_interop = {
				enable = true,
				border = "none",
				floating_preview_opts = {},
				peek_definition_code = {
					["<leader>df"] = "@function.outer",
					["<leader>dF"] = "@class.outer",
				},
			},
		},
	})
end

-- Telescope
local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
else
	telescope.setup({
	})
end

-- DAP
local status_ok, dap = pcall(require, "dap")
if not status_ok then
	return
else
	dap.adapters.python = {
		type = "executable",
		command = "python",
		args = { "-m", "debugpy.adapter" },
	}
	dap.configurations.python = {
		{
			type = "python",
			request = "launch",
			name = "My py",
			program = "${file}",
			pythonPath = function()
				return "python"
			end;
		},
	}
	local status_ok, dapui = pcall(require, "dapui")
	if not status_ok then
		return
	else
		dapui.setup({
			icons = { expanded = "-", collapsed = "+", current_frame = "" },
			layouts = {
				{
					elements = {
						{ id = "scopes", size = 0.75 },
						{ id = "stacks", size = 0.25 },
					},
					size = 0.20,
					position = "left",
				},
				{
					elements = {
						{ id = "repl",    size = 0.45 },
						{ id = "console", size = 0.55 },
					},
					size = 0.27,
					position = "bottom",
				},
			},
		})
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open("tray")
		end
	end
end

-- DAP virtual text
local status_ok, dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
if not status_ok then
	return
else
	dap_virtual_text.setup({
	})
end

-- DAP python
local status_ok, dap_python = pcall(require, "dap-python")
if not status_ok then
	return
else
	local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
	dap_python.setup(mason_path .. "packages/debugpy/venv/bin/python")
	dap_python.test_runner = "pytest"
end
