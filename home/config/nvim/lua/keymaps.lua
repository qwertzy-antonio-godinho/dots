-- Set leader
vim.g.mapleader = " "

-- Test keys
vim.cmd [[ :map <C-x> :echo "Key press is working!"<CR> ]]

-- Window management
vim.keymap.set("n", "<C-w>|", "<C-w>v")
vim.keymap.set("i", "<C-w>|", "<cmd>vert belowright sb<CR>")
vim.keymap.set("v", "<C-w>|", "<cmd>vert belowright sb<CR>")
vim.keymap.set("n", "<C-w>_", "<C-w>s")
vim.keymap.set("i", "<C-w>_", "<cmd>sb<CR>")
vim.keymap.set("v", "<C-w>_", "<cmd>sb<CR>")
vim.keymap.set("n", "<C-W>+", ":tabnew<CR>")
vim.keymap.set("n", "<C-W>-", ":tabclose<CR>")

-- Disable CTRL+z
vim.keymap.set("n", "<C-z>", "<nop>")
vim.keymap.set("v", "<C-z>", "<nop>")

-- CTRL+q (Quit)
vim.keymap.set("n", "<C-q>", ":qa!<CR>", { silent = true })
vim.keymap.set("i", "<C-q>", "<cmd>qa!<CR>", { silent = true })
vim.keymap.set("v", "<C-q>", "<cmd>qa!<CR>", { silent = true })

-- CTRL+s (Save)
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("i", "<C-s>", "<cmd>w<CR>")
vim.keymap.set("v", "<C-s>", "<cmd>w<CR>")

-- CTRL+z (Undo)
vim.keymap.set("i", "<C-z>", "<cmd>u<CR>")

-- CTRL+y (Redo)
vim.keymap.set("i", "<C-y>", "<cmd>redo<CR>")
