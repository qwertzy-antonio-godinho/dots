local global = vim.g
local option = vim.opt
local diagnostics = vim.diagnostic

global.loaded_netrw = 1
global.loaded_netrwPlugin = 1

-- Mouse
option.mouse = "a"

-- Line numbers
option.number = true

-- Cursor line
option.cursorline = true

-- Line wrap
option.wrap = true

-- Tabs
option.shiftwidth = 4
option.tabstop = 4
option.expandtab = true
option.breakindent = true
option.autoindent = true

-- Search
option.ignorecase = true
option.smartcase = true
option.incsearch = true

-- Format
option.encoding = "utf8" 
option.fileencoding = "utf8"

-- New buffers
option.splitbelow = true
option.splitright = true

-- Support files
option.swapfile = false
option.undofile = true
option.undodir = vim.fn.expand("~/.config/nvim/undo")
option.backup = false

-- Colors
option.termguicolors = true

-- UI
option.lazyredraw = false
option.updatetime = 50
option.showmode = false
option.laststatus = 3
option.fillchars = [[foldopen:-,foldclose:+,eob: ]]

-- Code column
option.colorcolumn = "120"

-- Folds
option.foldcolumn = "5"
option.foldlevel = 99
option.foldlevelstart = 99
option.foldenable = true

-- Signs
option.signcolumn = "yes:1"

-- Backspace
option.backspace = "indent,eol,start"

-- Clipboard
option.clipboard:append("unnamedplus")

-- Text
option.iskeyword:append("-")

-- Cursor
option.guicursor = "n-v-c-sm:block,i:ver20/lCursor"
