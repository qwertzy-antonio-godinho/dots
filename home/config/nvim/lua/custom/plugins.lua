return function(use)
  use({
    "xiyaowong/nvim-transparent",
      config = function()
        require("transparent").setup({
          enable = true,
          exclude = {},
        })
      end
  })
  use({
    "mhinz/vim-startify",
  })
  use({
    "noib3/nvim-cokeline", 
      requires = 'kyazdani42/nvim-web-devicons',
      config = function()
        require("cokeline").setup({
          buffers = {
            new_buffers_position = "next",
          },
          mappings = {
            cycle_prev_next = true
          },          
        })
      end
  })
  use({
    "max397574/better-escape.nvim",
      config = function()
        require("better_escape").setup()
      end
  })
  use({
    "rcarriga/nvim-notify",
  })
  use({
    "stevearc/dressing.nvim",
  })
  use({
    "folke/trouble.nvim",
      requires = "nvim-tree/nvim-web-devicons",
      config = function()
        require("trouble").setup {
          padding = false,
          auto_open = true,
          --auto_close = true,
        }
      end
  })
  use({
    "SmiteshP/nvim-navic",
      requires = "neovim/nvim-lspconfig",
  })
  use({ 
    "sindrets/diffview.nvim", 
      requires = "nvim-lua/plenary.nvim",
  })
  use({
  	"dstein64/nvim-scrollview",
      config = function()
        require("scrollview").setup({
          column = 1,
          winblend = 75,
        })
      end
  })
  use({
  	"RRethy/vim-illuminate",
      config = function()
        require("illuminate").configure({
        })
      end
  })
  use({
    "simrat39/desktop-notify.nvim",
  })
  use({
    'mfussenegger/nvim-dap-python',
    requires = {'mfussenegger/nvim-dap'},
  })
  use({
    'rcarriga/nvim-dap-ui',
      config = function() 
        require('dapui').setup()
      end
  })
  use({
    'theHamsta/nvim-dap-virtual-text',
      config = function() 
        require('nvim-dap-virtual-text').setup()
      end
  })
  use({
    "flazz/vim-colorschemes", 
  })
  use({
    "kevinhwang91/nvim-ufo", 
    requires = "kevinhwang91/promise-async"
  })
  use({
    "stevearc/aerial.nvim",
      lazymod = 'aerial',
      telescope_ext = 'aerial',
      config = function() 
        require('aerial').setup({
          layout = {
            default_direction = "prefer_left",
          },
          highlight_on_hover = false,
          show_guides = true,
        }) 
      end
  })
  config = function()
    require("desktop-notify").notify("Hello from NeoVim")
  end
  use({
    "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      requires = { 
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
      },
      lazymod = 'neo-tree',
      config = function()
        require("neo-tree").setup({
          window = {
            position = "right",
          },
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
        })
      end
  })
end
