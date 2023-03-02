-- Automatically source and re-compile packer whenever you save this file
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	command = "source <afile> | silent! LspStop | silent! LspStart | PackerCompile",
	group = packer_group,
	pattern = vim.fn.expand "$MYVIMRC",
})

-- Plugins
local status_ok, packer = pcall(require, "packer")
if status_ok then

return function(use)
	use "mhinz/vim-startify"
	use "flazz/vim-colorschemes"
	use {
		"lukas-reineke/indent-blankline.nvim",
		config = function()
		require("indent_blankline").setup {
			char_blankline = "┆",
			filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "startify" },
		    show_trailing_blankline_indent = false,
			show_current_context = true,
			show_current_context_start = true,
		}
		end	
	}
	use {
		"dstein64/nvim-scrollview",
		config = function()
		require("scrollview").setup {
			column = 1,
			--winblend = 75,
		}
		end
	}
	use {
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
		},
	}
	use "gelguy/wilder.nvim"
	use {
		"xiyaowong/nvim-transparent",
		config = function()
		require("transparent").setup {
			enable = true,
			exclude = {},
		}
		end
	}
	use {
		"folke/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
		config = function()
		require("trouble").setup {
			position = "bottom",
--			width = 30,
			icons = false,
			padding = false,
			--auto_open = true,
			--auto_close = true,
		}
		end
	}
	use {
		"nvim-telescope/telescope.nvim", tag = "0.1.1",
		requires = "nvim-lua/plenary.nvim",
		lazymod = "telescope",
		config = function()
		require("telescope").setup {
			defaults = {
				mappings = {
					i = {
						["<C-u>"] = false,
						["<C-d>"] = false,
					},
				},
			},
		}
		end
	}
	use {
		"nvim-treesitter/nvim-treesitter",
		run = function()
		pcall(require("nvim-treesitter.install").update { with_sync = true })
		end,	
	}
	use {
		"neovim/nvim-lspconfig",
		requires = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"j-hui/fidget.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
		require("mason").setup {}
		require("mason-tool-installer").setup {
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
				}
			)
		}
		require("fidget").setup {}
		end
	}
	use {
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
		requires = "nvim-treesitter/nvim-treesitter",
		config = function()
		require("nvim-treesitter.configs").setup {
			ensure_installed = { "python", "bash", "proto", "markdown", "lua", "yaml", "toml", "help", "vim", "ini", "diff", "dockerfile", "json", "regex", },
			highlight = { enable = true },
			indent = { enable = true, disable = { "python" } },
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
		}
		end	
	}
	use {
		"kevinhwang91/nvim-ufo",
		requires = "kevinhwang91/promise-async",
		config = function()
		require("ufo").setup {
		    provider_selector = function(bufnr, filetype, buftype)
      			return {"treesitter", "indent"}
    		end
		}
		end
	}
	use {
		"akinsho/bufferline.nvim",
		tag = "v3.*", 
		requires = "nvim-tree/nvim-web-devicons",
		config = function()
		require("bufferline").setup {
			options = {
				offsets = { 
					{ filetype = "neo-tree", text = "Explorer", },
					{ filetype = "Trouble", text = "Problems", },
					{ filetype = "aerial", text = "Symbols", },
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
		}
		end
	}
	
	use {
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = { 
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		lazymod = "neo-tree",
		config = function()
		require("neo-tree").setup {
			sources = {
				"filesystem",
			    "git_status",
			},
			enable_git_status = false,
			source_selector = {
				winbar = true,
				statusline = false,
				tab_labels = {
					filesystem = "Files",
					buffers =    "Buffers",
					git_status = "Git",
					diagnostics = "Diagnostics",
				},
			},
			close_if_last_window = true,
			window = {
				position = "right",
			},
			default_component_configs = {
				icon = {
            		folder_empty = "",
            		default = "≣",
            	},
            	git_status = {
            		symbols = {
						added     = "A",
						modified  = "M",
						deleted   = "D",
						renamed   = "R",
						untracked = "",
						ignored   = "-",
						unstaged  = "",
						staged    = "",
						conflict  = "‼",
            		},
            	},
			},
			enable_diagnostics = false,
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					hide_by_pattern = {
						"*/__pycache__",
						"*/.git",
						"*/.pytest_cache"
					},
				},
			},
		}
		end
	}
	use "stevearc/stickybuf.nvim"
	use {
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
		require("lualine").setup {
			options = {
				icons_enabled = true,
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
    			lualine_c = {{ "aerial",
    				sep = " > ",
    				depth = nil,
    				dense = false,
    				dense_sep = ".",
    				colored = true,
				}},
			},
		}
		end
	}
	use {
		"stevearc/aerial.nvim",
		lazymod = "aerial",
		telescope_ext = "aerial",
		config = function() 
		require("aerial").setup {
			layout = {
				default_direction = "left",
			},
			highlight_on_hover = false,
			show_guides = true,
			lsp = {
				diagnostics_trigger_update = true,
			    update_when_errors = true,
			},
		} 
		end
	}
	use {
		"mfussenegger/nvim-dap-python",
		requires = {"mfussenegger/nvim-dap"},
	}
	use {
		"rcarriga/nvim-dap-ui",
		config = function() 
		require("dapui").setup {
		icons = { expanded = "-", collapsed = "+", current_frame = "" },
layouts = {
  {
    elements = {
      { id = "scopes", size = 0.75 },
--      { id = "breakpoints", size = 0.17 },
      { id = "stacks", size = 0.25 },
  --    { id = "watches", size = 0.25 },
    },
    size = 0.20,
    position = "left",
  },
  {
    elements = {
      { id = "repl", size = 0.45 },
      { id = "console", size = 0.55 },
    },
    size = 0.27,
    position = "bottom",
  },
},	

	
		}
		end
	}
use {
  "nvim-neotest/neotest",
  requires = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-neotest/neotest-python",
  },
  		config = function() 
require("neotest").setup({
    floating = {
        border = "rounded",
        max_height = 0.85,
        max_width = 0.85,
        options = {}
    },
    log_level = 1,
  adapters = {
    require("neotest-python") {
    	dap = { justMyCode = false },
    	args = {"--log-level", "DEBUG"},
    	runner = "pytest",
    	python = "/usr/bin/python",
    },
  },
})
		end
}
	use {
		"theHamsta/nvim-dap-virtual-text",
		config = function() 
		require("nvim-dap-virtual-text").setup()
		end
	}
	use {
		"lewis6991/gitsigns.nvim",
		config = function()
		require("gitsigns").setup {
			signs = {
				add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
				change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
				delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
				topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
				changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
			    untracked = { text = "┆" },
			},
			preview_config = {
				border = "none",
				style = "minimal",
			},
			current_line_blame_formatter = "<author>, <author_time:%Y/%m/%d> - <summary>",
			current_line_blame = true,
			watch_gitdir = {
				interval = 700,
				follow_files = true
			},
			on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map("n", "]c", function()
			if vim.wo.diff then return "]c" end
			vim.schedule(function() gs.next_hunk() end)
			return "<Ignore>"
			end, {expr=true})

			map("n", "[c", function()
			if vim.wo.diff then return "[c" end
			vim.schedule(function() gs.prev_hunk() end)
			return "<Ignore>"
			end, {expr=true})

			-- Actions
			map({"n", "v"}, "<leader>hs", ":Gitsigns stage_hunk<CR>")
			map({"n", "v"}, "<leader>hr", ":Gitsigns reset_hunk<CR>")
			map("n", "<leader>hS", gs.stage_buffer)
			map("n", "<leader>hu", gs.undo_stage_hunk)
			map("n", "<leader>hR", gs.reset_buffer)
			map("n", "<leader>hp", gs.preview_hunk)
			map("n", "<leader>hd", gs.diffthis)
--			map("n", "<leader>hD", function() gs.diffthis("~") end)
			map("n", "<leader>td", gs.toggle_deleted)

			-- Text object
			map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>")
			end
		}
		end
	}
	end
end
