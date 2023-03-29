local status_ok, packer = pcall(require, "packer")
if status_ok then
	return function(use)
		use "tiagovla/tokyodark.nvim"
		use {
			"stevearc/aerial.nvim",
			lazymod = "aerial",
			telescope_ext = "aerial",
		}
		use "max397574/better-escape.nvim"
		use {
			"filipdutescu/renamer.nvim",
			branch = "master",
			requires = { { "nvim-lua/plenary.nvim" } }
		}
		use "m-demare/hlargs.nvim"
		use "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
		use {
			"neovim/nvim-lspconfig",
			requires = {
				"williamboman/mason.nvim",
				"williamboman/mason-lspconfig.nvim",
				"j-hui/fidget.nvim",
			},
		}
		use {
			"jose-elias-alvarez/null-ls.nvim",
			"jay-babu/mason-null-ls.nvim",
			requires = "williamboman/mason.nvim",
		}
		use {
			"mfussenegger/nvim-dap",
			requires = {
				"rcarriga/nvim-dap-ui",
				"mfussenegger/nvim-dap-python",
				"theHamsta/nvim-dap-virtual-text",
			},
		}
		use {
			"hrsh7th/nvim-cmp",
			requires = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-nvim-lsp-signature-help",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-buffer",
				"rcarriga/cmp-dap",
			},
		}
		use "folke/which-key.nvim"
		use "nvim-treesitter/nvim-treesitter-context"
		use "RRethy/vim-illuminate"
		use "nvim-telescope/telescope-dap.nvim"
		use "mhinz/vim-startify"
		use "lukas-reineke/indent-blankline.nvim"
		use "dstein64/nvim-scrollview"
		use "lewis6991/gitsigns.nvim"
		use {
			"kevinhwang91/nvim-ufo",
			requires = "kevinhwang91/promise-async",
		}
		use {
			"nvim-lualine/lualine.nvim",
			requires = "kyazdani42/nvim-web-devicons",
		}
		use {
			"nvim-telescope/telescope.nvim",
			tag = "0.1.1",
			requires = "nvim-lua/plenary.nvim",
			lazymod = "telescope",
		}
		use {
			"nvim-treesitter/nvim-treesitter-textobjects",
			after = "nvim-treesitter",
			requires = "nvim-treesitter/nvim-treesitter",
		}
		use "nvim-telescope/telescope-ui-select.nvim"
		use "nvim-lua/plenary.nvim"
		use {
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v2.x",
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-tree/nvim-web-devicons",
				"MunifTanjim/nui.nvim",
			},
			lazymod = "neo-tree",
		}
	end
end
