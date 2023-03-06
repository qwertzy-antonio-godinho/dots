local status_ok, packer = pcall(require, "packer")
if status_ok then
	return function(use)
		use {
			"neovim/nvim-lspconfig",
			requires = {
				"williamboman/mason.nvim",
				"williamboman/mason-lspconfig.nvim",
				"j-hui/fidget.nvim",
				"WhoIsSethDaniel/mason-tool-installer.nvim",
			},
		}
		use {
			"mfussenegger/nvim-dap",
			requires = {
				"rcarriga/nvim-dap-ui",
				"mfussenegger/nvim-dap-python",
				"theHamsta/nvim-dap-virtual-text",
			},
		}
		use "mhinz/vim-startify"
		use "tyrannicaltoucan/vim-deep-space"
		use "lukas-reineke/indent-blankline.nvim"
		use "dstein64/nvim-scrollview"
		use "lewis6991/gitsigns.nvim"
		use "gelguy/wilder.nvim"
		use "xiyaowong/nvim-transparent"
		use "stevearc/stickybuf.nvim"
		use {
			"stevearc/aerial.nvim",
			lazymod = "aerial",
			telescope_ext = "aerial",
		}
		use "Pocco81/auto-save.nvim"
		use "s1n7ax/nvim-window-picker"
		use {
			"folke/trouble.nvim",
			requires = "nvim-tree/nvim-web-devicons",
		}
		use {
			"kevinhwang91/nvim-ufo",
			requires = "kevinhwang91/promise-async",
		}
		use {
			"nvim-lualine/lualine.nvim",
			requires = "kyazdani42/nvim-web-devicons",
		}
		use {
			"sindrets/diffview.nvim",
			requires = "nvim-lua/plenary.nvim",
		}
		use {
			"nvim-treesitter/nvim-treesitter-textobjects",
			after = "nvim-treesitter",
			requires = "nvim-treesitter/nvim-treesitter",
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
		use {
			"akinsho/bufferline.nvim",
			tag = "v3.*",
			requires = "nvim-tree/nvim-web-devicons",
		}
		use {
			"nvim-telescope/telescope.nvim", 
			tag = "0.1.1",
			requires = "nvim-lua/plenary.nvim",
			lazymod = "telescope",
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
		}
	end
end
