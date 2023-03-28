vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.whichwrap:append "<>[]"
vim.opt.cursorline = true
vim.opt.wrap = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.breakindent = true
vim.opt.autoindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.encoding = "utf8"
vim.opt.fileencoding = "utf8"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.config/nvim/undo")
vim.opt.backup = false
vim.opt.lazyredraw = false
vim.opt.updatetime = 50
vim.opt.showmode = false
vim.opt.laststatus = 3
vim.opt.fillchars = {
	foldopen = "-",
	foldclose = "+",
	eob = " ",
}
vim.opt.shortmess:append "sI"
vim.opt.title = true
vim.opt.foldcolumn = "5"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.signcolumn = "yes:2"
vim.opt.backspace = "indent,eol,start"
vim.opt.clipboard:append("unnamedplus")
vim.opt.iskeyword:append("-")
vim.opt.guicursor = "n-v-c-sm:block,i:ver20/lCursor"
vim.opt.scrolloff = 5
vim.o.completeopt = 'menu,menuone,noselect'

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

local init_color_fg = vim.api.nvim_get_hl_by_name("CursorLineNr", true).foreground
local init_color_bg = vim.api.nvim_get_hl_by_name("CursorLineNr", true).background
vim.api.nvim_create_autocmd(
	{ "ModeChanged", "InsertLeave"},
	{
		desc = "change cursor color on mode change",
		group = group,
		callback = function()
			local mode = vim.api.nvim_get_mode().mode
			if mode == "i" then
				vim.api.nvim_set_hl(0, "CursorLineNr", {fg="#000000", bg="#ac3131", bold=true})
			elseif mode == "v" or mode == "V" or mode == "" then
				vim.api.nvim_set_hl(0, "CursorLineNr", {fg="#000000", bg="#d1d1d1", bold=true})
			else
				vim.api.nvim_set_hl(0, "CursorLineNr", {fg=init_color_fg, bg=init_color_bg, bold=true})
			end
		end,
	}
)
