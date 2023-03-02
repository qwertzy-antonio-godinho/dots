-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require "user.packer"
require "user.plugins"
require "user.keys"
require "user.options"
