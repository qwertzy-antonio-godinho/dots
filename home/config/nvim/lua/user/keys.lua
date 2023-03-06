local keymap = vim.keymap

-- Set leader
vim.g.mapleader = " "

-- Test keys
vim.cmd [[ :map <C-x> :echo "Key press is working!"<CR> ]]

-- Window management
keymap.set("n", "<C-w>|", "<C-w>v")
keymap.set("i", "<C-w>|", "<cmd>vert belowright sb<CR>")
keymap.set("v", "<C-w>|", "<cmd>vert belowright sb<CR>")
keymap.set("n", "<C-w>_", "<C-w>s")
keymap.set("i", "<C-w>_", "<cmd>sb<CR>")
keymap.set("v", "<C-w>_", "<cmd>sb<CR>")
keymap.set("n", "<C-W>+", ":tabnew<CR>")
keymap.set("n", "<C-W>-", ":tabclose<CR>")

-- Disable CTRL+z
keymap.set("n", "<C-z>", "<nop>")
keymap.set("v", "<C-z>", "<nop>")

-- CTRL+q (Quit)
keymap.set("n", "<C-q>", ":qa!<CR>", { silent = true })
keymap.set("i", "<C-q>", "<cmd>qa!<CR>", { silent = true })
keymap.set("v", "<C-q>", "<cmd>qa!<CR>", { silent = true })

-- CTRL+s (Save)
keymap.set("n", "<C-s>", ":w<CR>")
keymap.set("i", "<C-s>", "<cmd>w<CR>")
keymap.set("v", "<C-s>", "<cmd>w<CR>")

-- CTRL+z (Undo)
keymap.set("i", "<C-z>", "<cmd>u<CR>")

-- CTRL+y (Redo)
keymap.set("i", "<C-y>", "<cmd>redo<CR>")

-- LSP
local status_ok, lsp = pcall(require, "vim.lsp")
if not status_ok then
	return
else
	keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
	keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "[G]oto [I]mplementation" })
	keymap.set("n", "<leader>td", vim.lsp.buf.type_definition, { desc = "[T]ype [D]efinition" })
	keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
	keymap.set("n", "<leader>doc", vim.lsp.buf.hover, { desc = "Hover [Doc]umentation" })
	keymap.set("n", "<leader>sig", vim.lsp.buf.signature_help, { desc = "[Sig]nature Documentation" })
	keymap.set("n", "<leader>gde", vim.lsp.buf.declaration, { desc = "[G]oto [Dec]laration" })
	keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, { desc = "[W]orkspace [L]ist Folders" })
	local on_attach = function(_, bufnr)
		vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
			vim.lsp.buf.format()
		end, { desc = "Format current buffer with LSP" })
	end
end

-- Aerial
local status_ok, aerial = pcall(require, "aerial")
if not status_ok then
	return
else
	keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
end

-- Trouble
local status_ok, trouble = pcall(require, "trouble")
if not status_ok then
	return
else
	keymap.set("n", "<leader>t", "<cmd>TroubleToggle<CR>")
end

-- NeoTree
local status_ok, neotree = pcall(require, "neo-tree")
if not status_ok then
	return
else
	keymap.set("n", "<leader>f", "<cmd>NeoTreeShowToggle<CR>")
end

-- Telescope
local status_ok, telescope = pcall(require, "telescope.builtin")
if not status_ok then
	return
else
	keymap.set("n", "<leader>ds", telescope.lsp_document_symbols, { desc = "[D]ocument [S]ymbols" })
	keymap.set("n", "<leader>ws", telescope.lsp_dynamic_workspace_symbols, { desc = "[W]orkspace [S]ymbols" })
	keymap.set("n", "<leader>gr", telescope.lsp_references, { desc = "[G]oto [R]eferences" })
	keymap.set("n", "<leader>sf", telescope.find_files, { desc = "[S]earch [F]iles" })
	keymap.set("n", "<leader>sg", telescope.live_grep, { desc = "[S]earch by [G]rep" })
	keymap.set("n", "<leader>sd", telescope.diagnostics, { desc = "[S]earch [D]iagnostics" })
	keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>")
	keymap.set("n", "<leader>gcf", "<cmd>Telescope git_bcommits<cr>")
	keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>")
	keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") 
	keymap.set("n", "<leader>/", function()
		telescope.current_buffer_fuzzy_find(
			require("telescope.themes").get_dropdown {
				previewer = false,
			}
		)
	end, { desc = "[/] Fuzzily search in current buffer]" })
end

-- DAP
local status_ok, dap = pcall(require, "dap")
if not status_ok then
	return
else
	keymap.set("n", "<F1>", dap.step_over)
	keymap.set("n", "<F2>", dap.step_into)
	keymap.set("n", "<F3>", dap.step_out)
	keymap.set("n", "<F4>", dap.close)
	keymap.set("n", "<F5>", dap.continue)
	keymap.set("n", "<leader>b", dap.toggle_breakpoint)
	keymap.set("n", "<leader>dr", dap.repl.open)
end

-- DAP Python
local status_ok, dap_python = pcall(require, "dap-python")
if not status_ok then
	return
else
	keymap.set("n", "<leader>dt", dap_python.test_method)
	keymap.set("n", "<leader>dc", dap_python.test_class)
end

-- Gitsigns
local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
	return
else
	keymap.set("n", "<leader>hp", package.loaded.gitsigns.preview_hunk_inline)
	keymap.set("n", "<leader>hd", package.loaded.gitsigns.diffthis)
end

