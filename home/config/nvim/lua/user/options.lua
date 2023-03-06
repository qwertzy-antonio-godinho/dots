local option = vim.opt

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
--option.softtabstop = 4
option.tabstop = 4
option.expandtab = true
option.breakindent = true
option.autoindent = true

-- Search
option.ignorecase = true
option.smartcase = true
option.incsearch = true

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

-- Diagnostics
vim.diagnostic.config({
	virtual_text = {
		prefix = '∎',
	},
	severity_sort = true,
	signs = false,
	underline = true,
	float = {
		source = "always",
	},
	update_in_insert = true,
})
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- Python format
vim.cmd [[au BufWritePost *.py :silent !black %]]
