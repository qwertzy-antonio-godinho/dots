-- Set <SPACE> as leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Automatically source and re-compile packer whenever you save this file
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})

-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "<C-q>", ":qa<CR>", { silent = true })
map("i", "<C-q>", "<cmd>qa<CR>", { silent = true })
map("v", "<C-q>", "<cmd>qa<CR>", { silent = true })

map("n", "<C-S-q>", ":qa!<CR>", { silent = true })
map("i", "<C-S-q>", "<cmd>qa!<CR>", { silent = true })
map("v", "<C-S-q>", "<cmd>qa!<CR>", { silent = true })

map("n", "<C-s>", ":w<CR>", { silent = true })
map("i", "<C-s>", "<cmd>w<CR>", { silent = true })
map("v", "<C-s>", "<cmd>w<CR>", { silent = true })

map("n", "<C-z>", ":u<CR>", { silent = true })
map("i", "<C-z>", "<cmd>u<CR>", { silent = true })
map("v", "<C-z>", "<cmd>u<CR>", { silent = true })

map("n", "<C-S-z>", "<C-R>", { silent = true })
map("i", "<C-S-z>", "<cmd>redo<CR>", { silent = true })
map("v", "<C-S-z>", "<cmd>redo<CR>", { silent = true })

vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>')
vim.keymap.set('n', '<leader>t', '<cmd>TroubleToggle<CR>')
vim.keymap.set('n', '<leader>f', '<cmd>NeoTreeShowToggle<CR>')

-- Telescope keys
local status, plugin = pcall(require,"telescope")
if not status then
    return
else
	vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
	vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
	vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
	vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
	vim.keymap.set("n", "<leader>/", function()  require("telescope.builtin").current_buffer_fuzzy_find(
		require("telescope.themes").get_dropdown {
			--winblend = 10,
			previewer = false,
		}
	)
	end, { desc = "[/] Fuzzily search in current buffer]" })
end

-- DAP
vim.keymap.set("n", "<F5>", ":lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<F1>", ":lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<F2>", ":lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<F3>", ":lua require'dap'.step_out()<CR>")
vim.keymap.set("n", "<F4>", ":lua require'dap'.close()<CR>")
vim.keymap.set("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>")
vim.keymap.set("n", "<leader>dt", ":lua require'dap-python'.test_method()<CR>")
vim.keymap.set("n", "<leader>dc", ":lua require'dap-python'.test_class()<CR>")
